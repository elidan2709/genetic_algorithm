unit ConfigParser;

interface

uses math, sysutils;

type
ConfigT = record

	left_border: real; // левая граница поиска
	right_border: real; // правая граница поиска

	mode: string; // режим алгоритма (min/max)
	population_volume: integer; // размер начальной популяции
	max_iters: integer; // максимальное число итераций
	quality_epsilon: real; // точность улучшения
	max_valueless_iters: integer; // максимальное число итераций без улучшения
	enough_function_value: real; // априорно заданное значение целевой функции

	preserved_high_positions: real; // доля защищённого количества особей сверху
	preserved_low_positions: real; // доля защищённого количества особей снизу
	selection_mode: string; // тип селекции
	cut_part: real; // часть для отсечения режима cut

	crossbreeding_mode: string; // тип скрещивания
	crossing_part: real; // доля особей, участвующих в скрещивании
	crossuniform_probability: real; // вероятность выбора бит первого родителя

	mutation_method: string; // тип мутации
	variability: real; // доля мутирующих особей

	debug_file: string; // файл отладки
	print_screen: boolean; // нужно ли выводить на экран
	
end;
  
function ReadConfig(path: string; var config: ConfigT): boolean; // считывание конфига
procedure PrintConfig(config: ConfigT); // вывод конфигурации

implementation  

// инициализация конфигурации
function InitConfig(): ConfigT;
var config: ConfigT;
	begin
	config.left_border := 0; // левая граница = 0
	config.right_border := 4; // правая граница = 4
	config.mode := 'max'; // минимум функци по умолчанию
	config.population_volume := 30;
	config.max_iters := 100;
	config.quality_epsilon := 1e-5;
	config.max_valueless_iters := 5;
	config.enough_function_value := 2;
	config.preserved_high_positions := 0.1; // 10% сверху по умолчанию защищены
	config.preserved_low_positions := 0.1; // 10% снизу по умолчанию защищены
	config.selection_mode := 'cut'; // отбираем усечением
	config.cut_part := 0.4; // 40% популяции будут сохранено
	config.crossbreeding_mode := 'universal'; // универсальное скрещивание
	config.crossing_part := 0.2; // 20% участвуют в скрещивании
	config.crossuniform_probability := 0.5; // вероятность первого родителя
	config.mutation_method := 'random'; // случайные мутации
	config.variability := 0.1; // 10% доля мутирующих особей
	config.debug_file := ''; // выключаем отладку по умолчанию
	config.print_screen := false; // не нужно выводить на экран
	
	InitConfig := config; 
	end;
  
  // получение значения из строки
function GetText(line: string; var start: integer): string;
var s: string;
	begin
	while (start <= length(line)) and ((line[start] = ' ') 
		or (line[start] = '=')) do
		start := start + 1;
	   
	s := '';

	while (start <= length(line)) and (line[start] <> ' ') 
		and (line[start] <> '=') do 
		begin
	  
		s := s + line[start];
		start := start + 1;
		
		end;

	GetText := s; 
	end;
    
// обработка строки
function ProcessLine(line: string; var config: ConfigT): boolean;
var
i: integer;
error: integer;
key, value: string;
tmp: real;
	begin
	i := 1;   
	key := GetText(line, i);
	value := GetText(line, i);
	error := 0; 

	if (key = 'left_border') or (key = 'left') 
		or (key = 'a') then 
		begin
		val(value, config.left_border, error);
		
		if error <> 0 then
			writeln('Invalid left border value inverval (', value, ')');
		end
	else if (key = 'right_border') or (key = 'right') 
		or (key = 'b') then 
		begin
		val(value, config.right_border, error);
	  
		if error <> 0 then
		writeln('Invalid right border value interval (', value, ')');
		end
	else if key = 'mode' then begin
	  config.mode := value;
	  
	if (value <> 'min') and (value <> 'max') then
		begin
		error := 1;
		writeln('Invalid algorithm mode (', value, ')');
		end;
	end
	else if key = 'population_volume' then
		begin
		val(value, config.population_volume, error);
		
		if config.population_volume < 2 then 
			begin
			error := 1;
			writeln('Invalid init population volume value (', value, ')');
			end;
		end
	else if key = 'max_iters' then 
		begin
		val(value, config.max_iters, error);
		
		if config.max_iters < 1 then 
			begin
			error := 1;
			writeln('Invalid maximum iteration value (', value, ')');
			end;
		end
	else if key = 'quality_epsilon' then 
		begin
		val(value, config.quality_epsilon, error);
	  
		if (config.quality_epsilon <= 0) or (config.quality_epsilon >= 1) then 
			begin
			error := 1;
			writeln('Invalid quality epsilon value (', value, ')');
			end;
		end
	else if key = 'max_valueless_iters' then 
		begin
		val(value, config.max_valueless_iters, error);
		
		if config.max_valueless_iters < 1 then 
			begin
			error := 1;
			writeln('Invalid max valueless iterations value (', value, ')');
			end;
	end
	else if key = 'enough_function_value' then 
		begin
		val(value, config.enough_function_value, error);
	  
		if error <> 0 then
			writeln('Invalid enough function value (', value, ')');
		end
	else if key = 'preserved_high_positions' then 
		begin
		val(value, config.preserved_high_positions, error);
	  
		if (config.preserved_high_positions <= 0) or 
				(config.preserved_high_positions > 1) then 
			begin
			error := 1;
			writeln('Invalid preserved high positions value (', value, ')');
			end;
		end
	else if key = 'preserved_low_positions' then 
		begin
		val(value, config.preserved_low_positions, error);
	  
		if (config.preserved_low_positions < 0) or 
				(config.preserved_low_positions > 1) then
			begin
			error := 1;
			writeln('Invalid preserved low positions value (', value, ')');
			end;
		end
	else if key = 'cut_part' then 
		begin
		val(value, config.cut_part, error);
	  
		if (config.cut_part < 0) or (config.cut_part > 1) then 
			begin
			error := 1;
			writeln('Invalid cutt part value (', value, ')');
			end;
		end
	else if key = 'selection_mode' then 
		begin
		config.selection_mode := value;
	  
		if (value <> 'cut') and (value <> 'roulette') then 
			begin
			error := 1;
			writeln('Unknown selection mode (', value, ')');
			end;
		end  
	else if key = 'crossbreeding_mode' then 
		begin
		config.crossbreeding_mode := value;
	  
		if (value <> 'one-point') and (value <> 'two-point') and 
				(value <> 'universal') and (value <> 'uniform') then 
			begin
			error := 1;
			writeln('Unknown crossbreeding mode (', value, ')');
			end;
		end
	else if key = 'crossing_part' then 
		begin
		val(value, config.crossing_part, error);
	  
		if (config.crossing_part <= 0) or (config.crossing_part > 1) then 
			begin
			error := 1;
			writeln('Invalid crossbreeding part value (', value, ')');
			end;
		end
	else if key = 'crossuniform_probability' then 
		begin
		val(value, config.crossuniform_probability, error);
	  
		if (config.crossuniform_probability <= 0) or 
				(config.crossuniform_probability > 1) then 
			begin
			error := 1;
			writeln('Invalid probability for uniform crossbreeding (', value, ')');
			end;
		end
	else if key = 'mutation_method' then 
		begin
		config.mutation_method := value;
	  
		if (value <> 'random') and (value <> 'swap') and 
				(value <> 'reverse') then 
			begin
			error := 1;
			writeln('Unknown mutation mode (', value, ')');
			end;
		end
	else if key = 'variability' then 
		begin
		val(value, config.variability, error);
	  
		if (config.variability <= 0) or (config.variability > 1) then 
			begin
			error := 1;
			writeln('Invalid variability value (', value, ')');
			end;
		end
	else if key = 'debug_file' then 
		begin
		config.debug_file := value + '.txt';
		end
	else if key = 'print_screen' then 
		begin
		if (value = 'true') or (value = '') then
			config.print_screen := true
		else if value = 'false' then
		  config.print_screen := false
	else 
		begin
		error := 1;
		writeln('Invalid print screen value (', value, ')');
		end;
	end
	else
		begin
		error := 1;
		writeln('Unknown parameter ''', key , '''');
		end;

	// если границы интервала не в том порядке, то меняем их местами
	if config.left_border > config.right_border then 
		begin
		tmp := config.left_border;
		config.left_border := config.right_border;
		config.right_border := tmp;
		end;

	ProcessLine := error = 0;
	end;
  
// считывание конфига
function ReadConfig(path: string; var config: ConfigT): boolean;
var
isCorrect:boolean; 
f:text; 
line:string; 
	begin
	config := InitConfig(); 

	if not fileexists(path) then 
		begin
		writeln('Config file is not found, use default values');
		isCorrect := true;
		end
	else 
		begin
		assign(f, path); 
		reset(f); 

		isCorrect := true; 

		while not eof(f) do begin
			readln(f, line); 
			
		if (line = '') or (line[1] = '#') then
			continue; 
	  
		line := LowerCase(line); 
	  
		if not ProcessLine(line, config) then 
			begin 
			isCorrect := False; 
			end;
	  end;

	  close(f); // закрываем файл
	end;

	if config.debug_file <> '' then
		begin
		assign(f, config.debug_file);
		rewrite(f); 
		close(f); 
		end;

	ReadConfig := isCorrect; 
	end;

// вывод конфигурации
procedure PrintConfig(config: ConfigT);
	begin
    writeln('Algorithm mode: ', config.mode);
    writeln('Search space: [', config.left_border:0:2, ', ',
				config.right_border:0:2, ']');
    writeln('Quality epsilon: ', config.quality_epsilon);
    writeln;
    writeln('Population size: ', config.population_volume);
    writeln('Total iterations: ', config.max_iters);
    writeln('Valueless iterations: ', config.max_valueless_iters);
    writeln('Enough function value: ', config.enough_function_value:0:3);
    writeln;
    writeln('Preserved high positions: ', 
			floor(config.population_volume * 
				config.preserved_high_positions));
    writeln('Preserved low positions: ', 
			floor(config.population_volume * 
				config.preserved_low_positions));
    write('Selection mode: ');
    
    if config.selection_mode = 'cut' then 
		begin
		writeln('cut');
		writeln('Отсекаемые особи: ', 
			floor(config.population_volume * config.cut_part));
		end
    else
		writeln('roulette');  
    writeln;
    writeln('Crossbreeding mode: ', config.crossbreeding_mode);
    
    if config.crossbreeding_mode = 'uniform' then
        writeln('Uniform probability: ', 
			config.crossuniform_probability:0:2);
    writeln('Crossbreeding part: ', config.crossing_part:0:2);
    writeln;
    writeln('Mutation mode: ', config.mutation_method);
    writeln('Mutation probability: ', config.variability:0:2);
    writeln;
	end;
  
begin
end.
