unit ImplementModule;

interface

uses MasmModule, Entity, ConfigParser;

function CrossBreed(entity1, entity2: EntityT; config: ConfigT): EntityT;
procedure Mutate(var entity: EntityT; mode: string);

implementation 
// скрещивание
function CrossBreed(entity1, entity2: EntityT; config: ConfigT): EntityT;
	begin
	if config.crossbreeding_mode = 'one-point' then
		CrossBreed := OnePointCrossBreed(entity1, entity2) 
	else if config.crossbreeding_mode = 'two-point' then
		CrossBreed := TwoPointCrossBreed(entity1, entity2) 
	else if config.crossbreeding_mode = 'universal' then
		CrossBreed := UniversalCrossBreed(entity1, entity2, 
				config.crossuniform_probability) 
	else if config.crossbreeding_mode = 'uniform' then
		CrossBreed := UniformCrossBreed(entity1, entity2) 
	end;

// мутация в зависимости от режима
procedure Mutate(var entity: EntityT; mode: string);
	begin
	if mode = 'random' then
		RandomMutation(entity)
	else if mode = 'swap' then
		SwapMutation(entity)
	else
		ReverseMutation(entity);
	end;

begin
end.




