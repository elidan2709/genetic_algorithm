unit PopulationModule;

interface

uses math, ConfigParser, Entity, MasmModule, ImplementModule;

type

PopulationT = record
	entities: packed array of EntityT;
	n: integer; 
end;
  
function InitPopulation(n: integer): PopulationT; // создание популяции
procedure PrintPopulation(epoch: integer; population: PopulationT; 
		config: ConfigT); // вывод популяции
procedure CrossbreedPopulation(var population: PopulationT; 
		config: ConfigT; count: integer); // скрещивание
procedure MutatePopulation(var population: PopulationT;
		config: ConfigT); // мутация популяции
procedure UniquePopulation(var population: PopulationT; 
		config:ConfigT); // уникализация популяции
procedure ScorePopulation(var population: packed array of entityT; config: ConfigT; f: FunctionT);// Оценка особей
{procedure EvalPopulation(population: PopulationT; config: ConfigT; f: FunctionT);} // Сортировка
procedure EvalPopulation(var population: packed array of entityT; len: longword); stdcall;
	external name 'sort';
	{$L MasmModule.obj}// Сортировка
{procedure EvalPopulation(var population: packed array of entityT; len: longword); // Сортировка}

implementation

// создание популяции
function InitPopulation(n: integer): PopulationT;
var
population: PopulationT; 
i: integer; 
	begin
	
	randseed := 7;
	SetLength(population.entities, n); 
	population.n := n;

	for i := 0 to n - 1 do
		population.entities[i] := InitEntity(); 

	InitPopulation := population; 
	end;

// вывод популяции
procedure ScreenPrintPopulation(epoch: integer; 
									population: PopulationT);
var i: integer;
	begin
	writeln('Epoch ', epoch, ':');
	for i := 0 to population.n - 1 do 
		begin
		write('  ', (i + 1):3, ') ');
		ScreenPrintEntity(population.entities[i]); 
		end;
	writeln;
	end;

// вывод популяции в файл
procedure FilePrintPopulation(epoch: integer; var f: text; 
									population: PopulationT);
var i: integer;
	begin
	writeln(f, 'Epoch ', epoch, ':');
	for i := 0 to population.n - 1 do 
		begin
		write(f, '  ', (i + 1):3, ') ');
		FilePrintEntity(f, population.entities[i]); 
		end;
	writeln(f);
	end;

// вывод популяции
procedure PrintPopulation(epoch: integer; population: PopulationT; 
								config: ConfigT); 
var
f: text; 
x, y: real;
	begin  
	if config.debug_file <> '' then 
		begin
		assign(f, config.debug_file);
		append(f); 
		FilePrintPopulation(epoch, f, population); 
		close(f); 

			if config.print_screen then 
				ScreenPrintPopulation(epoch, population) 
			else 
				begin
				x := EvalEntity(population.entities[0], 
							config.left_border, config.right_border);
				y := population.entities[0].score;
	  
				writeln('Epoch ', epoch:3, ', x: ',
								x:0:10, ', y: ', y:0:10);   
				end;
		end
	else
		begin
		x := EvalEntity(population.entities[0], config.left_border, 
								config.right_border);
		y := population.entities[0].score;

		writeln('Epoch ', epoch:3, ', x: ', x:0:10, ', y: ', y:0:10);
		end;
	end;

// скрещивание популяции
procedure CrossbreedPopulation(var population: PopulationT; config: ConfigT; count: integer);
var
parents: integer;
i: integer;
parent1, parent2: EntityT;
	begin
	parents := floor(count * config.crossing_part); 

	for i := count to population.n - 1 do 
		begin
		parent1 := population.entities[random(parents)]; 
		parent2 := population.entities[random(parents)]; 

		population.entities[i] := CrossBreed(parent1, parent2, config); 
		end;
	end;

// мутация популяции
procedure MutatePopulation(var population: PopulationT; config: ConfigT);
var 
start: integer;
i: integer;
	begin
	start := round(population.n * config.preserved_high_positions);
	  
	for i := start to population.n - 1 do
		if random < config.variability then
			Mutate(population.entities[i], config.mutation_method);
	end;
	
// уникализация популяции 
procedure UniquePopulation(var population:PopulationT; config:ConfigT); 
var 
i, j:integer; 
	begin
	for i := 0 to population.n - 1 do
		for j := i + 1 to population.n - 1 do
			if population.entities[i].bits = 
							population.entities[j].bits then
				population.entities[j] := InitEntity();
	end;
{	
// оценка приспособленности особей
procedure EvalPopulation(population: PopulationT; config: ConfigT; f: FunctionT);
var
i, j: integer; 
p: integer; // множитель для сортировки
tmp: EntityT; 
	begin
	if config.mode = 'max' then
		p := -1
	else
		p := 1;

	// оцениваем каждую особь и выполняем сортировку вставками
	for i := 0 to population.n - 1 do 
		begin
		ScoreEntity(population.entities[i], f, 
				config.left_border, config.right_border); 

		// вставляем особь на нужное место
		j := i;
		while (j > 0) and ((population.entities[j - 1].score 
							- population.entities[j].score) * p > 0) do 
			begin
			tmp := population.entities[j];
			population.entities[j] := population.entities[j - 1];
			population.entities[j - 1] := tmp;
			j := j - 1;
			end;
		end;
	end;
}
procedure ScorePopulation(var population: packed array of entityT; config: ConfigT; f: FunctionT);
var
	i: integer; 
begin
	for i := 0 to length(population) - 1 do
		ScoreEntity(population[i], f, 
				config.left_border, config.right_border);
end;
{
// сортировка
procedure EvalPopulation(var population: packed array of entityT; len: longword); 
var
	i, j: integer; 
	swap_real : real;
	swap_longint : longint; 
begin				
	for i := 0 to len - 1 do 
		for j := i + 1 to len - 1 do
		begin
			if population[i].score < population[j].score then
			begin
				swap_longint := population[i].bits;
				population[i].bits := population[j].bits;
				population[j].bits := swap_longint;
				swap_real := population[i].score;
				population[i].score := population[j].score;
				population[j].score := swap_real;
			end;			
		end;
end;
}
begin
  
end.
