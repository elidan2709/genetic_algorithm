unit MasmModule;

interface

uses Entity, ConfigParser, BitOperations;

function OnePointCrossBreed(entity1, entity2: EntityT): EntityT; stdcall;
	external name 'o_p_crbd';
	{$L MasmModule.obj} // одноточечное скрещивание
function TwoPointCrossBreed(entity1, entity2: EntityT): EntityT; stdcall;
	external name 't_p_crbd';
	{$L MasmModule.obj} // двуточечное скрещивание
function UniversalCrossBreed(entity1, entity2: EntityT; p: real): EntityT; stdcall;
	external name 'univ_crbd';
	{$L MasmModule.obj} // универсальное скрещивание
function UniformCrossBreed(entity1, entity2: EntityT): EntityT; stdcall;
	external name 'unif_crbd';
	{$L MasmModule.obj} // однородное скрещивание
procedure RandomMutation(var entity: EntityT); stdcall;
	external name 'rand_mut';
	{$L MasmModule.obj }// случайная мутация
procedure SwapMutation(var entity: EntityT); stdcall; 
	external name 'swap_mut';
	{$L MasmModule.obj} // мутация перестановкой битов
procedure ReverseMutation(var entity: EntityT); stdcall;
	external name 'rev_mut';
	{$L MasmModule.obj} // мутация реверсом части битов

implementation

begin
end.
