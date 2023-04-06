unit Selection;

interface

uses ConfigParser, Entity, PopulationModule;

function MakeSelection(var population: PopulationT; config: 
								ConfigT): integer; // селекция

implementation

// отбор методом усечения
function CutSelection(var population: PopulationT; 
								config: ConfigT): integer;
	begin
	CutSelection := round(population.n * config.cut_part); 
	end;

// отбор методом рулетки
function RouletteSelection(var population: PopulationT; 
									config: ConfigT): integer;
var
i, j: integer; 
sum: real; // сумма значений оценки приспособленности
pi: real; // вероятность выбрать особь
min_value, max_value, delta: real; 
	begin
	sum := 0;

	if config.mode = 'max' then 
		begin
		min_value := population.entities[population.n - 1].score;
		max_value := population.entities[0].score;
		end
	else 
		begin
		min_value := population.entities[0].score;
		max_value := population.entities[population.n - 1].score;
		end;

	delta := max_value - min_value;

	// считаем сумму оценки приспособленности
	for i := 0 to population.n - 1 do
		begin
		population.entities[i].score := (population.entities[i].score - min_value) / delta;
		sum := sum + population.entities[i].score;
		end;

	j := 0; // новый индекс для вставки
	pi := 1.0;

	for i := 0 to population.n - 1 do
		begin       
		if random() < pi then 
			begin
			population.entities[j] := population.entities[i]; 
			j := j + 1; 
		end;

	pi := pi - population.entities[i].score / sum;
	end;

	RouletteSelection := j; 
	end;

// селекция
function MakeSelection(var population: PopulationT;
								config: ConfigT):integer;
var
count:integer;
	begin
	if config.selection_mode = 'cut' then
		count := CutSelection(population, config)
	else if config.selection_mode = 'roulette' then
		count := RouletteSelection(population, config);

	MakeSelection := count;
	end;

begin
  
end.
