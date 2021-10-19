grammar fortecreuson;

@header { import java.util.*; }
@members {
	Variavel x = new Variavel();
	ControleVariavel cv = new ControleVariavel();
	String saida="";
	int escopo;
	int tipo;
	String nome;
}

inicio: 'inicio'{ escopo = 0; saida+="public class Saida{\n\t";}
                {saida += "\tpublic static void main(String args[]){\n";}
      declvar
      cmd
      'fim' {saida+="\t}\n";}
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
    'int' { tipo = 0; saida+="int "; }
  | 'char' { tipo = 1; saida+="char "; } 
  | 'double' { tipo = 2; saida+="double "; } 
);

cmd: (cond | atrib)*;

cond: 'se' {saida+="if"; } AP {saida+="("; } comp FP {saida+=")"; } AC {saida+="{"; } cmd FC {saida+="}"; }
		('senao' {saida+="else"; }AC {saida+="{"; }cmd FC {saida+="}"; })?;
comp: (ID | NUM) OPREL (ID | NUM);
atrib: 	ID {Variavel var1 = cv.busca($ID.text);}
		Op_atrib
		(ID {Variavel var2 = cv.busca($ID.text);
			 if(var1.getTipo()!=var2.getTipo()){
				System.out.println("Atribuição invalida");
				System.exit(0);
			 }
			}
		| NUM)
		;

ID: [A-Za-z]+;
NUM: [0-9]+;
OPREL: '>' | '<' | '>=' | '<=' | '==' | '!=' ;
PV: ';' ;
AC: '{' ;
FC: '}' ;
AP: '(' ;
FP: ')' ;
Op_atrib: '=';
WS: [ \t\r\n]+ -> skip;