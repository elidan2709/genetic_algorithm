unit Entity;

interface

const

M = 30; 
TwoM = 1 shl M; // максимальное число возможных особей

type

EntityT = record

	bits: longint; 
	score: real; 
  
end;
  
FunctionT = function(x: real): real; 

function InitEntity(): EntityT; // инициализация особи
function EvalEntity(entity: EntityT; a, b: real): real; // получение численного значения особи
procedure ScoreEntity(var entity: EntityT; f: FunctionT; a, b: real); // получение оценки приспособленности особи
procedure ScreenPrintEntity(entity: EntityT); // вывод особи
procedure FilePrintEntity(var f: text; entity: EntityT); // вывод особи в файл
 
implementation

// инициализация особи
function InitEntity(): EntityT;
var entity: EntityT;
	begin
	
	entity.bits := random(TwoM); 
	InitEntity := entity; 
	
	end;

// получене численного значения особи
function EvalEntity(entity: EntityT; a, b: real): real;
	begin
	
	EvalEntity := a + entity.bits * (b - a) / TwoM;
	
	end;
  
// получение оценки приспособленности особи
procedure ScoreEntity(var entity: EntityT; f: FunctionT; a, b: real);
var x: real;
	begin

	x := EvalEntity(entity, a, b); 
	entity.score := f(x); 

	end;

// вывод особи
procedure ScreenPrintEntity(entity: EntityT);
var i: integer;
	begin
	write('entity: ', entity.score:0:10, ', bits: [ ');
	  
	for i := M - 1 downto 0 do
		write((entity.bits shr i) and 1, ' ');
	  
	writeln('] (int value: ', entity.bits, ')');
	end;

// вывод особи в файл
procedure FilePrintEntity(var f: text; entity: EntityT);
var i: integer;
	begin
	write(f, 'entity: ', entity.score:0:10, ', bits: [ ');
	  
	for i := M - 1 downto 0 do
		write(f, (entity.bits shr i) and 1, ' ');
	  
	writeln(f, '] (int value: ', entity.bits, ')');
	end;

end.
