// Se define la gramática LogoTEC del programa
grammar gramatica;

// Se define la regla del lenguaje. Debe tener mínimo un comentario, un ID o un programa
programa
    :
    (definiciones | procedimiento)+
    ;

/****** PARSER DEL LENGUAJE ******/

/* Definiciones del programa */
definiciones
    :
    (ID | centro | goma | giraderecha | giraizquierda | aparecetortuga |
    bajalapiz | subelapiz | ejecuta | retrocede | valor | avanza | inc | inic|
    asignacion | lista | dowhile | si | ifelse | hazhasta | mientras | until |
    poncolorlapiz | ponx | mayorque | pony | rumbo | ponrumbo | ponpos | ponxy |
    menorque | iguales | espera | repite | y | o | ocultatortuga | azar)+
    ;


/*** Condiciones ***/

/* Evaluación de IF */
si
    :
    SI
    condicion
    instrucciones+
    {System.out.println("Se evaluó un SI");}
    ;

/* Definición de if else */
ifelse
    :
    IFELSE
    condicion
    instrucciones+
    instrucciones+
    ;

/* Definición de haz.hasta (se ejecuta y luego se comprueba) */
// Se ejecutan las instrucciones tantas veces hasta que se cumpla la condición. Se ejecuta al menos 1 vez
hazhasta
    :
    HAZHASTA
    instrucciones+
    condicion
    ;

/* Definición de hasta (se comprueba si se cumple y luego, si NO se cumple, se ejecuta) */
// Se ejecutan las instrucciones tantas veces hasta que se cumpla la condición. Si se cumple, no se ejecuta ni una vez
until
    :
    HASTA
    condicion
    instrucciones+
    ;

/* Definición de mientras (se comprueba si se cumple y luego, si se cumple, se ejecuta) */
// Se ejecutan las instrucciones tantas veces mientras que se cumpla la condición. Si no se cumple, no se ejecuta ni una vez
mientras
    :
    MIENTRAS
    condicion
    instrucciones+
    ;

/* Definición de haz.mientras (se ejecuta y luego se prueba si se cumple) */
// Se ejecutan las instrucciones tantas veces mientras que se cumpla la condición. Se ejecuta al menos una vez
dowhile
    :
    HAZMIENTRAS
    instrucciones+
    condicion
    ;

/* Condición (se evalúa si es cierto) */
condicion
    :
    (PARENI | CORCHETEI)
          (INT | ID | CHAR)
            (IGUAL | MNRIQ | MYRQ | MYRIQ | DIFERENTE)
          (INT | ID | CHAR)
    (PAREND | CORCHETED)
    ;

/* Instrucciones (ejecuta lo que esté entre corchetes )*/
instrucciones
    :
        (CORCHETEI
        // Primera posible salida
        (
            SALIDA
            (CHAR | INT | FLOAT | HILERA)
        )
        CORCHETED)
        |
        // Otras posibles salidas
        CORCHETEI*
        (
            procedimiento | suma | resto | diferencia | producto | avanza | giraderecha|
            division | potencia | hazhasta | dowhile | asignacion | repite | ejecuta |
            redondea | menos | mientras | until | si | ifelse
        )
        CORCHETED*
    ;

/*** Variables ***/

/* Asigna un valor a una variable */
asignacion
    :
    HAZ
    ID
    (HILERA | INT | CHAR | FLOAT)
    ;

/* Definición de inic */
inic
    :
    INIC
    ID
    IGUAL
    valor
    ;

/* Definición de INC */
inc
    :
    (INC
    CORCHETEI
    ID
    CORCHETED
    )
    |
    (INC
    CORCHETEI
    ID (INT | ID)
    CORCHETED
    )
    ;

/*** Comparaciones ***/

/* Definición de MayorQue? */
mayorque
    :
    MAYORQUE
    (ID | valor) (ID | valor)
    ;

/* Definición de MenorQue? */
menorque
    :
    MENORQUE
    (ID | valor) (ID | valor)
    ;

/* Definición de iguales */
iguales
    :
    IGUALES
    (ID | valor) (ID | valor)
    ;

/*** Movimientos tortuga ***/

/* Definición de Avanza */
avanza
    :
    AVANZA
    (INT | ID)
    ;

/* Definición de Retrocede */
retrocede
    :
    RETROCEDE
    (INT | ID)
    ;

/* Definición de GiraDerecha */
giraderecha
    :
    GDERECHA
    (INT | ID)
    ;

/* Definición de GiraIzquierda */
giraizquierda
    :
    GIZQUIERDA
    (INT | ID)
    ;

/* Definición de OcultaTortuga */
ocultatortuga
    :
    OTORTUGA
    ;

/* Definición de ApareceTortuga */
aparecetortuga
    :
    ATORTUGA
    ;

/* Definición de PonPOS */
ponpos
    :
    PONPOS
    (INT | ID)
    (INT | ID)
    ;

/* Definición de PonXY */
ponxy
    :
    PONXY
    (INT | ID)
    (INT | ID)
    ;

/* Definición de PonRumbo */
ponrumbo
    :
    PRUMBO
    (INT | ID)
    ;

/* Definición de rumbo */
rumbo
    :
    RUMBO
    |
    MUESTRA RUMBO
    ;

/* Definición de PosX */
ponx
    :
    PONX
    (INT | ID)
    ;

/* Definición de PonY */
pony
    :
    PONY
    (INT | ID)
    ;

/* Definición de GOMA */
goma
    :
    GOMA
    ;

/* Definición de BajaLapiz */
bajalapiz
    :
    BAJA
    ;

/* Definición de SubeLapiz */
subelapiz
    :
    SUBE
    ;

/* Definición de PonColorLapiz */
poncolorlapiz
    :
    COLOR
    // Se debe agregar el color
    ;

/* Definición de centro */
centro
    :
    CENTRO
    ;

/* Definición de esperar */
espera
    :
    ESPERA
    INT
    ;

/* Definición de ejecutar */
ejecuta
    :
    EJECUTA
    instrucciones+
    ;

/* Definición de repetir */
repite
    :
    // Si se quieren repetir varias instrucciones
    (REPITE
    (INT | ID)
    CORCHETEI
    instrucciones+
    CORCHETED)
    |
    // Si se quiere repetir solo una instrucción
    (REPITE
    (INT | ID)
    instrucciones)
    ;

/* Se define de manera general posibles valores para acceso fácil */
valor
    :
    // Valores que puede tener una lista
    ( suma | diferencia | potencia | resto
    | division |  producto | menos | redondea
    | CHAR | ID | INT | FLOAT)
    ;

/* Definición de listas */
lista
    :
    // Lista vacía
    (CORCHETEI
     CORCHETED)
     |
     // Lista con uno o más valores
     (CORCHETEI
        (valor | HILERA) (COMA (valor | HILERA))*
     CORCHETED)
    ;

/*** Operaciones matemáticas ***/

/* Definición de suma de N números */
suma
    :
    SUMAR
    (INT |  ID)+
    ;

/* Definición de diferencia (resta de N números) */
diferencia
    :
    DIFERENCIA
    (INT |  ID)+
    ;

/* Definición de multiplicación de N números */
producto
    :
    PRODUCTO
    (INT |  ID)+
    ;

/* Definición de división de un N1 entre N2 */
division
    :
    DIVISION
    (INT |  ID)+
    (INT |  ID)+
    ;

/* Definición de residuo de división de un N1 entre N2 */
resto
    :
    RESTO
    (INT | ID)
    (INT | ID)
    ;

/* Definición de potencia de un N1 elevado a N2 */
potencia
    :
    POTENCIA
    (INT | ID)
    (INT | ID)
    ;

/* Definición de cambio de signo */
menos
    :
    MENOS
    (INT | ID)
    ;

/* Definición de redondeo de un décimal al entero más próximo */
redondea
    :
    REDONDEA
    (FLOAT | ID)
    ;

/* Definición de azar */
azar
    :
    AZAR
    (INT |  ID)
    ;

/*** Definiciones lógicas ***/

/* Definición del O lógico */
o
    :
    OR
    condicion
    condicion
    ;

/* Definición del Y lógico */
y
    :
    AND
    condicion
    condicion
    ;

expression
    : expression AND expression
    | expression OR expression
    | procedimiento
    | instrucciones
    | HILERA
    | INT
    | FLOAT
    | CHAR
    | ID
    ;

procedimiento
        : (PARA
          ID
          CORCHETEI
          parametros?
          CORCHETED
          instrucciones+
          FIN)
          |
          (PARA
          ID
          instrucciones+
          FIN)
        ;

parametros
    : expression ( ',' expression )*
    ;

/*** Definiciones de funciones del lenguaje ***/

/****** LEXER DEL LENGUAJE ******/

/* Condiciones básicas */
SI : 'SI';
IFELSE : 'SISINO';
MIENTRAS : 'MIENTRAS';
HASTA : 'HASTA';
HAZMIENTRAS : 'HAZ.MIENTRAS';
HAZHASTA : 'HAZ.HASTA';
AND : 'Y';
OR : 'O';

/*** Palabras reservadas del lenguaje ***/

/* Asignación o cambios de variables */
HAZ : 'Haz';
INIC : 'INIC';
INC : 'INC';

/* Procedimientos */
PARA : 'PARA';
FIN : 'FIN';

/* Operaciones */
SUMAR : 'Suma';
DIFERENCIA : 'Diferencia';
PRODUCTO : 'Producto';
DIVISION : 'División';
RESTO : 'Resto';
POTENCIA : 'Potencia';
MENOS : 'Menos';
REDONDEA : 'Redondea';

/* Funciones básicas del lenguaje */
AZAR : 'Azar';
SALIDA : 'Salida';
MUESTRA : 'MUESTRA';
CENTRO : 'Centro';
ESPERA : 'Espera';
EJECUTA : 'Ejecuta';
REPITE : 'Repite';

/* Funciones gráficas del lenguaje */
BORRAR : 'BorraPantalla';
COLOR : 'PonColorLapiz' | 'poncl';
SUBE : 'SubeLapiz' | 'sb';
BAJA : 'BajaLapiz' | 'bl';
GOMA : 'GOMA' | 'GO';

/* Direcciones de la tortuga */
RUMBO : 'Rumbo';
PRUMBO : 'PonRumbo';
GIZQUIERDA : 'GiraIzquierda' | 'GI';
GDERECHA : 'GiraDerecha' | 'GD';
RETROCEDE : 'Retrocede' | 'RE';
AVANZA : 'Avanza' | 'AV';

/* Posiciones X Y de la tortuga */
PONY : 'PonY';
PONX : 'PonX';
PONPOS : 'PonPOS';
PONXY : 'Ponxy';

/* Funciones de la tortuga */
ATORTUGA : 'ApareceTortuga';
OTORTUGA : 'OcultaTortuga';

/* Funciones de listas */
ELEGIR : 'Elegir';
CUENTA : 'Cuenta';
ULTIMO : 'Ultimo' | 'ul';
ELEMENTO : 'Elemento';
PRIMERO : 'Pri';

/* Comparaciones del lenguaje */
IGUALES : 'Iguales?';
MAYORQUE : 'MayorQue?';
MENORQUE : 'MenorQue?';

// Diferentes símbolos utilizados
PUNTOYC : ';';
PARENI : '(';
PAREND : ')';
CORCHETEI : '[' ;
CORCHETED : ']' ;
COMA : ',';

// Operadores básicos
MAS : '+';
SMENOS : '-';
MULT : '*';
DIV : '/';
MOD : '%';

// Operadores de comparación
IGUAL : '=';
DIFERENTE : '!=';
MNRQ : '<';
MNRIQ : '<=';
MYRQ : '>';
MYRIQ : '>=';

// Variables
ID : [a-z][A-Za-z0-9_@&-]*;

// Números enteros
INT : [0-9]+;

// Decimal
FLOAT : [0-9]+'.'[0-9]+;

// Letras (caracteres / characters)
CHAR : ['] ('a'..'z' | 'A'..'Z') ['];

// String
HILERA : ["] [A-Za-z0-9_]* ["];

/* Se mantienen en channel HIDDEN ya que no son de uso para el parser y solo se usan para mejor entendimiento del código */

// Para los comentarios del código fuente del programa
COMENTARIO : '//' ~( '\r' |'\n')+ NEWLINE* -> channel(HIDDEN);

// WS: WhiteSpace (espacios en blanco)
WS : (' '| '\t')+ -> channel(HIDDEN);

// Nueva línea
NEWLINE : [ \r\n] -> channel(HIDDEN);