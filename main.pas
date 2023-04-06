uses ConfigParser, Entity, PopulationModule, Selection, MasmModule, ImplementModule, sysutils;


function f(x: real): real;
	begin
	f := (x - 2) * (x - 2.5) * (x - 3.5) * (1 - exp(x - 1.5));
	end;
	
var
config: ConfigT; // конфигурация алгоритма
population: PopulationT; // популяция
epoch: integer; // текущая эпоха
count: integer; // число особей для скрещивания
scale:real;
prev_best, curr_best:real; // лучшие значения поиска
nochanging_iter:integer; // число итераций без изменения
WorkTime, StartTime, EndTime: longword;  // время работы

begin
	if not ReadConfig('config.txt', config) then 
		exit; 

	PrintConfig(config);
	
	StartTime := GetTickCount64();
	
	population := InitPopulation(config.population_volume); 
	epoch := 0; 

	// множитель для оценки достаточного значения функции
	if config.mode = 'max' then
		scale := 1
	else
		scale := -1;

	nochanging_iter := 0;
	prev_best := 0;

	while epoch <= config.max_iters do 
		begin
		ScorePopulation(population.entities, config, @f);
		EvalPopulation(population.entities, length(population.entities)); 
		PrintPopulation(epoch, population, config);

		curr_best := population.entities[0].score; 


		if (curr_best - config.enough_function_value) * scale > 0 then 
			begin
			writeln('Enough function value achived: ', 
						config.enough_function_value:0:10);
			break; 
			end;

		if (epoch > 0) and (abs(prev_best - curr_best) < 
								config.quality_epsilon) then 
			begin
			nochanging_iter := nochanging_iter + 1; 
			writeln('Score has not improved, (iteration: ', nochanging_iter, ')');

			if nochanging_iter >= config.max_valueless_iters then 
				begin
				writeln('Score has not improved over ', nochanging_iter, ' epoches'); 
				break;
			end;
		end
		else
			nochanging_iter := 0; 
	// шаг алгоритма
	prev_best := curr_best; 
	count := MakeSelection(population, config);
	CrossbreedPopulation(population, config, count); 
	MutatePopulation(population, config); 
	UniquePopulation(population, config); 
	epoch := epoch + 1;
	end;
	
	EndTime := GetTickCount64();
	WorkTime := EndTime - StartTime;
	
	writeln;
	writeln ('Program work time:', WorkTime);
end.
