// =========================================================================
// Cajero Autom�tico - Sistema de Gesti�n Bancaria (b�sico)
// Autor: Otton Lucena
// Descripci�n: Sistema que simula las operaciones b�sicas de un cajero autom�tico
//              incluyendo consulta de saldo, retiros, dep�sitos y cambio de PIN
// =========================================================================

// -------------------------------------------------------------------------
// Funci�n: cambioPin
// Descripci�n: Gestiona el proceso de cambio de PIN del usuario
// Par�metros: 
//   - pinInicial: PIN actual del usuario
// Retorna: Nuevo PIN si el cambio es exitoso, 0 si hay error
// --------------------------------------------------------------------------
Funcion pinActual <- cambioPin (pinInicial)
	
	Definir pin1, pin2, pinActual Como Entero;;
	
	Escribir "Digite su PIN actual:";
	Leer pinActual;
	
	Si pinActual == pinInicial Entonces
		Escribir "Escriba su nuevo PIN: ";
		Leer pin1;
		Escribir "Vuelva a ingresar su nuevo PIN: ";
		Leer pin2;
		Borrar Pantalla;
		
		//Validaci�n de coincidencias
		Si pin1 == pin2 Entonces
			Esperar 1 Segundos;
			Escribir "PIN actualizado correctamente.";
			pinActual = pin2;
		SiNo
			Escribir "ERROR: Los PIN ingresados no coinciden.";
			pinActual = 0;
		FinSi
	SiNo
		Escribir "ERROR: PIN actual incorrecto";
		pinActual = 0;
	FinSi
	
Fin Funcion

// -------------------------------------------------------------------------
// Funci�n: girarDinero
// Descripci�n: Procesa el retiro de dinero validando el saldo disponible
// Par�metros:
//   - saldo: Saldo actual en la cuenta
// Retorna: Saldo actualizado despu�s del retiro
// -------------------------------------------------------------------------
Funcion saldoActual <- girarDinero ( saldo )
	
	Definir girado, saldoActual Como Entero;
	
	Escribir "Ingrese saldo a girar: ";
	Leer girado;
	
	//Validaci�n de monto m�nimo y m�ximo
	Si girado < 1 O girado > saldo Entonces
		Escribir "No puede retirar menos de $1";
		Escribir "No puede retirar m�s de saldo actual: ", saldo;
		saldoActual = saldo;
	SiNo
		saldoActual = saldo - girado;
		Escribir "Dinero girado exitosamente, saldo actual :", saldoActual;
	FinSi
Fin Funcion

// -------------------------------------------------------------------------
// Funci�n: abonarDinero
// Descripci�n: Procesa el dep�sito de dinero en la cuenta
// Par�metros:
//   - saldo: Saldo actual en la cuenta
// Retorna: Saldo actualizado despu�s del dep�sito
// -------------------------------------------------------------------------
Funcion saldoActual <- abonarDinero ( saldo )
	
	Definir abonado, saldoActual Como Entero;
	
	Escribir "Ingrese dinero abonar: ";
	Leer abonado;
	
	//Validaci�n de monto m�nimo
	Si abonado < 1 Entonces
		Escribir "No puede abonar un saldo inferiror a $1";
		saldoActual = saldo;
	SiNo
		saldoActual = saldo + abonado;
		Escribir "Dinero abonado, su saldo actual es: ", saldoActual;
	FinSi
Fin Funcion

// -------------------------------------------------------------------------
// Funci�n: mostrarMenu
// Descripci�n: Muestra el men� principal de opciones y captura la selecci�n
// Par�metros:
//   - x: Par�metro de control (no utilizado actualmente)
// Retorna: Opci�n seleccionada por el usuario
// -------------------------------------------------------------------------
Funcion opcionElegida <- mostrarMenu(x)
	
	Definir opcionElegida Como Entero;
	
	Escribir "1. Ver saldo actual";
	Escribir "2. Abonar dinero";
	Escribir "3. Girar dinero";
	Escribir "4. Cambiar PIN";
	Escribir "5. Salir del programa";
	Leer opcionElegida;
Fin Funcion

// -------------------------------------------------------------------------
// Funci�n: mostrarSaldo
// Descripci�n: Muestra el saldo actual al usuario
// Par�metros:
//   - saldo: Saldo actual en la cuenta
// -------------------------------------------------------------------------
Funcion  mostrarSaldo (saldo)

	Escribir "Su saldo actual es: $", saldo;
	Escribir "Presione una tecla para continuar..";
	Esperar Tecla;
Fin Funcion

// -------------------------------------------------------------------------
// Funci�n: mostrarBienvenida
// Descripci�n: Gestiona el proceso de autenticaci�n del usuario
// Par�metros:
//   - pinDefault: PIN predeterminado del sistema
// Retorna: Verdadero si la autenticaci�n es exitosa, Falso en caso contrario
// -------------------------------------------------------------------------
Funcion validado <- mostrarBienvenida(pinDefault)
	
	Definir rutDefault Como Entero;
	Definir rut,pin Como Entero;
	Definir intentos Como Entero;
	Definir validado Como Logico;
	
	//Inicializaci�n de variables de control
	validado = falso;
	intentos = 0;
	rutDefault = 12345678;
	pinDefault = pinDefault;

	Escribir "Bienvenido a nuestro cajero automatico";
	Escribir FechaActual();
	Escribir "Por favor ingrese su RUT y PIN";
	Escribir "Digite su RUT:";
	Leer rut;
	
	// Validaci�n de RUT y PIN
	Si rut = rutDefault Entonces
		Mientras intentos < 3 Y NO validado Hacer
			Escribir "Digite su PIN:";
			Leer pin;
			Si pin = pinDefault Entonces
				validado <- Verdadero;
				Limpiar Pantalla;
				Escribir "Usuario autentificado.";
			SiNo
				intentos <- intentos + 1;
				Si intentos = 3 Entonces
					Borrar Pantalla;
					Escribir "ERROR: Usuario NO autentificado";
				SiNo
					Escribir "PIN INCORRECTO, INTENTE NUEVAMENTE";
					Si intentos = 2 Entonces
						Escribir "Queda ", 3 - intentos, " intento";
					SiNo
						Escribir "Quedan ", 3 - intentos, " intentos";
					FinSi
				FinSi
			FinSi
		FinMientras
	SiNo
		Escribir "RUT INCORRECTO, TRANSACCI�N FALLIDA.";
	FinSi
	
	//Mensaje en caso de exceder intentos de PIN.
	Si NO validado Y intentos = 3 Entonces
		Escribir "Ha excedido el n�mero m�ximo de intentos";
	FinSi
Fin Funcion

// =========================================================================
// Algoritmo Principal: cajero_OttonLucena
// Descripci�n: Punto de entrada principal del sistema que coordina todas
//              las operaciones del cajero autom�tico
// =========================================================================
Algoritmo cajero_OttonLucena
	// Declaraci�n de variables principales
	Definir elegido Como Logico;
	Definir menu, saldoInicial, pinDefault, nuevoPin Como Entero;
	
	// Inicializaci�n de valores por defecto
	pinDefault = 1234;
	saldoInicial= 10000;
	
	// Proceso de autenticaci�n
	elegido <- mostrarBienvenida(pinDefault);
	
	// Bucle principal del programa
	Repetir
		Si elegido Entonces
			menu = mostrarMenu(menu);
		FinSi
		
		// Gesti�n de opciones del men�
		Si elegido Y menu = 1 Entonces
			mostrarSaldo(saldoInicial);
		FinSi
		Si elegido Y menu = 2 Entonces
			saldoInicial = abonarDinero(saldoInicial);
		FinSi
		Si elegido Y menu = 3 Entonces
			saldoInicial = girarDinero(saldoInicial);
		FinSi
		Si elegido Y menu = 4 Entonces
			Borrar Pantalla;
			pinDefault = cambioPin(pinDefault);
			Si pinDefault = 0 Entonces
				menu <- 5;
			SiNo
				Escribir "Presione una tecla para continuar...";
				Esperar tecla;
			FinSi
			
		FinSi
	Hasta Que menu = 5;
	
FinAlgoritmo
