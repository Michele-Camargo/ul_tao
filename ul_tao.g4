grammar ul_tao;

@header { import java.util.*; }
@members {
	Variavel x = new Variavel();
	ControleVariavel cv = new ControleVariavel();
	String saida="";
	int escopo;
	int tipo;
	String nome;
}

inicio: 'ul'{ escopo = 0; saida+="public class Saida {\n";}
                {saida += "\tpublic static void main(String args[]){\n";}
      declvar
      cmd
      'tao' {saida+="\n\t}\n";}
            {saida+="}\n";}
            {System.out.println(saida);};

declvar: (tipo
         ID { saida += $ID.text;
            x = new Variavel($ID.text, tipo, escopo);
            boolean resultado = cv.adiciona(x);
            if(!resultado){
              System.out.println("Variavel "+$ID.text+" ja foi declarada!");
              System.exit(0);
            }
          } 
        PV { saida+=";\n"; } 
      )* ;

tipo: (
    'tonynt' { tipo = 0; saida+="\t\tint "; }
  | 'charcolate' { tipo = 1; saida+="\t\tchar "; } 
  | 'doublebis' { tipo = 2; saida+="\t\tdouble "; } 
);

atrib: 	ID 
  {Variavel var1 = cv.busca($ID.text);
    if(var1 == null) { 
      System.out.println("Variavel: "+$ID.text+" nao declarada!");
      System.exit(0); 
    } else { 
      saida+="\n\t\t"+$ID.text+" = "; }
  } 
		Op_atrib
		(ID 
      {
        Variavel var2 = cv.busca($ID.text);

        if(var2 == null) { 
              System.out.println("variavel "+$ID.text+" nao declarada!");
              System.exit(0); 
        }

			 if(var1.getTipo()!=var2.getTipo()){
				System.out.println("Atribuicao de "+var2.getNome()+" e invalida pois o tipo de "+var1.getNome()+" e diferente");
				System.exit(0);
			 }

      saida+=$ID.text;

			}
		| NUM { 
      if(var1.getTipo() != 0 && var1.getTipo() != 2){
        System.out.println("Atribuicao de tipo invalida em: "+var1.getNome());
				System.exit(0);
      }
     saida+=$NUM.text; }
     | DOUBLE { 
      if(var1.getTipo() != 2){
        System.out.println("Atribuicao de tipo invalida em: "+var1.getNome());
      }
      saida+=$DOUBLE.text;
     }
    | CHAR {
      if(var1.getTipo() != 1){
        System.out.println("Atribuicao de tipo invalida em: "+var1.getNome());
				System.exit(0);
      }
       saida+=$CHAR.text; }
    | expressao
    )
    PV { saida+=$PV.text; } 
		;

cmd: (cond | atrib | repwhile | repdowhile )*;

comp: (ID  { Variavel var1 = cv.busca($ID.text);
    if(var1 == null) { 
      System.out.println("Variavel: "+$ID.text+" nao declarada!");
      System.exit(0); 
    } else { 
      saida+=$ID.text; }
  } | NUM { saida+=$NUM.text; } | DOUBLE { saida+=$DOUBLE.text; }) OPREL { saida+=" "+$OPREL.text+" "; } (ID  {Variavel var1 = cv.busca($ID.text);
    if(var1 == null) { 
      System.out.println("Variavel: "+$ID.text+" nao declarada!");
      System.exit(0); 
    } else { 
      saida+=$ID.text; }
  } | NUM { saida+=$NUM.text; } | DOUBLE { saida+=$DOUBLE.text; });


cond: 'se' {saida+="\n\n\t\tif"; } AP {saida+="("; } comp FP {saida+=")"; } AC {saida+="{"; } cmd FC {saida+="\n\t\t}"; }
		('senao' {saida+="\n\t\telse"; } AC {saida+="{"; } cmd FC {saida+="\n\t\t}\n"; })?;

repwhile: 'enquanto' {saida+="\n\n\t\twhile"; } AP {saida+="("; } comp FP {saida+=")";} AC {saida+="{"; } cmd FC {saida+="\n\t\t}";};

repdowhile: 'faca' {saida+="\n\n\t\tdo"; } AC  {saida+="{"; } cmd FC {saida+="}"; }
            'enquanto' {saida+="\n\t\twhile"; } AP {saida+="("; } comp FP {saida+=")"; } PV { saida+=$PV.text; } ;

expressao: (ID {
        Variavel var2 = cv.busca($ID.text);

        if(var2 == null) { 
              System.out.println("variavel "+$ID.text+" nao declarada!");
              System.exit(0); 
        }

			 if(var2.getTipo()!=0 && var2.getTipo()!=2){
				System.out.println("Nao e possivel montar uma expressao com a variavel "+var2.getNome()+" tipo invalido");
				System.exit(0);
			 }

      saida+=$ID.text;

			} | NUM {saida+=$NUM.text;} 
        | DOUBLE {saida+=$DOUBLE.text;}) OPERADOR { saida+=" "+$OPERADOR.text+" "; } 
        (ID {
        Variavel var2 = cv.busca($ID.text);

        if(var2 == null) { 
              System.out.println("variavel "+$ID.text+" nao declarada!");
              System.exit(0); 
        }

			 if(var2.getTipo()!=0 && var2.getTipo()!=2){
				System.out.println("Nao e possivel montar uma expressao com a variavel "+var2.getNome()+" tipo invalido");
				System.exit(0);
			 }

      saida+=$ID.text;

       }
       | NUM {saida+=$NUM.text;} 
       | DOUBLE {saida+=$DOUBLE.text;} 
       | expressao
       | AP { saida+="("; } expressao FP { saida+=")"; }
       );

ID: [A-Za-z]+;
NUM: [0-9]+;
DOUBLE: [0-9]+.[0-9]+;
CHAR: '"'.?'"';
OPERADOR: '+' | '-' | '*' | '/'; 
OPREL: '>' | '<' | '>=' | '<=' | '==' | '!=' ;
PV: ';' ;
AC: '{' ;
FC: '}' ;
AP: '(' ;
FP: ')' ;
Op_atrib: '=';
WS: [ \t\r\n]+ -> skip;