uses GraphABC;

const
  slovar: array of string = ('дом','дым','зуб','лес','нож','нос','рис',
                             'рот','суд','ухо','банк','бобр','вино','вода','врач',
                             'глаз','гора','зима','ключ','кофе','куст','лето',
                             'лист','мозг','море','мост','мясо','небо','нога','ночь',
                             'окно','пиво','поле','река','рука','рыба','сеть','снег',
                             'стол','стул','хлеб','храм',
                             'билет','взрыв','волна','дверь','диван',
                             'дождь','еврей','завод','земля','канал','карта',
                             'класс','книга','крыло','крыша','кулак','лодка',
                             'масло','мешок','огонь','орган','пакет','палец',
                             'плечо','поезд','птица','рубль','сапог','семья',
                             'скотч','слеза','спина','стена','судья','сфера',
                             'толпа','трава','труба','','','','','','','','','','','','','','','');
  digits: set of char = ['1','2','3','4','5','6','7','8','9','0'];
  prob=10;

var
  skeleton:array of string;
  x0,y0:integer;

{
Function Kostil(s:string;i1,i2:integer):array of string;
var 
  t:array of string;
begin
  setlength(t,3);
  t[0]:=s;
  t[1]:=IntToStr(i1);
  t[2]:=IntToStr(i2);
  Kostil:=t;
end;
}

Function IsDigit(c:char):boolean;//TCharacter.IsDigit почему то не сработала
begin
    IsDigit:=c in digits;
end;

Function CutNum(s,cs:string): string;
var
  i,j:integer;
  t:string;
  a:string;
begin
  t:='';
  for i:=1 to Length(s) do begin
    for j:=1 to Length(s)-i+1 do begin
    //write(i,' ',j,' ',copy(s, i, j) , ' ' , IntToStr(i-1) ,' ',IntToStr(Length(s)-j-i+1));
    a:=copy(s, i, j);
    if a = cs then begin
      t:=IntToStr(i-1) + IntToStr(Length(s)-j-i+1);
      Break;
      end;
    end;
  end;
  CutNum:=t;
end;

Function Cut(s:string): Set of string;
var
  i,j:integer;
  t:set of string;
  a:string;
begin
  for i:=1 to Length(s) do begin
    for j:=1 to Length(s)-i+1 do begin
    //write(i,' ',j,' ',copy(s, i, j) , ' ' , IntToStr(i-1) ,' ',IntToStr(Length(s)-j-i+1));
    a:=copy(s, i, j);
    Include(t,a);
    end;
  end;
  Cut:=t;
end;

function Perebor(s:string):string;
var
  i: Integer;
  t,d,b:string;
begin
  b:='';
  for i := Low(slovar) to High(slovar) do begin
    t:=slovar[i];
    if s in Cut(t) then begin  
      d:=CutNum(t,s);
      b:=d[1]+t+d[2];
      Break;
      end;
    end;  
  Perebor:=b;
end;

Function Rebusi(s:string):boolean;
var 
  i:integer;
  t1,t2,t3:string;
  b:boolean;
begin
  s:=lowercase(s);
  b:=false;
  if Length(s) = 1 then begin
    //write(s);
    setlength(skeleton,length(skeleton)+1);
    skeleton[length(skeleton)-1]:=s;
    exit;
  end; 
  if s <> '' then begin
    for i:=5 downto 2 do begin
      t1:=copy(s, 1, i);
      
      t2:=Perebor(t1);
      if t2 <> '' then begin
        t3:=copy(s, i+1, Length(s) - i+1);
        b:=True;
        setlength(skeleton,length(skeleton)+1);
        skeleton[length(skeleton)-1]:=t2;
        //write(t2,' ');
        break;
      end;
    end;
    if b then Rebusi(t3)
    else begin
      setlength(skeleton,length(skeleton)+1);
      skeleton[length(skeleton)-1]:=s[1];
      //write(s[1],' ');
      t3:=copy(s, 2, Length(s) - 1);
      Rebusi(t3);
    end;    
  end
  else
    //write(s);
end;

procedure DrawRebus(data:array of string);
var 
  i,j,n1,n2:integer;
  t:string;
  Ris:Picture;
begin
  for i:=0 to Length(data)-1 do
    if IsDigit(data[i][1]) then begin
      SetFontSize(20);
      t:=data[i];
      t:=copy(t, 2, Length(t)-2);
      Ris:=Picture.Create('Images/'+t+'.png');
      
      n1:=strtoint(data[i][1]);
      for j:=1 to n1 do begin
        TextOut(x0,y0,',');
        x0:=x0+prob;
        end;
        
      Ris.Draw(x0,y0-50,100,100);
      x0:=x0+110;      
        
      n2:=strtoint(data[i][length(data[i])]);
      for j:=1 to n2 do begin
        TextOut(x0-5,y0-45,$'{#039}');
        x0:=x0+prob;
        end;
        
      //write(t,' ');
      end
    else begin
      SetFontSize(40);
      TextOut(x0,y0-20,Uppercase(data[i]));
      x0:=x0+prob*5;
      end;
      //write(data[i],' ');  
end;

var 
  s:string;
begin
  s:='тест';
  
  //writeln(s);
  
  Rebusi(s);
  //writeln(skeleton);
  
  x0:=10;
  y0:=100;
  DrawRebus(skeleton);
  
end.