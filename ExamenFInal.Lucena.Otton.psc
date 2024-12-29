// =========================================================================
// Cajero Automático - Sistema de Gestión Bancaria (básico)
// Autor: Otton Lucena
// Descripción: Sistema que simula las operaciones básicas de un cajero automático
//              incluyendo consulta de saldo, retiros, depósitos y cambio de PIN
// =========================================================================

// -------------------------------------------------------------------------
// Función: cambioPin
// Descripción: Gestiona el proceso de cambio de PIN del usuario
// Parámetros: 
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
		
		//Validación de coincidencias
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
// Función: girarDinero
// Descripción: Procesa el retiro de dinero validando el saldo disponible
// Parámetros:
//   - saldo: Saldo actual en la cuenta
// Retorna: Saldo actualizado después del retiro
// -------------------------------------------------------------------------
Funcion saldoActual <- girarDinero ( saldo )
	
	Definir girado, saldoActual Como Entero;
	
	Escribir "Ingrese saldo a girar: ";
	Leer girado;
	
	//Validación de monto mínimo y máximo
	Si girado < 1 O girado > saldo Entonces
		Escribir "No puede retirar menos de $1";
		Escribir "No puede retirar más de saldo actual: ", saldo;
		saldoActual = saldo;
	SiNo
		saldoActual = saldo - girado;
		Escribir "Dinero girado exitosamente, saldo actual :", saldoActual;
	FinSi
Fin Funcion

// -------------------------------------------------------------------------
// Función: abonarDinero
// Descripción: Procesa el depósito de dinero en la cuenta
// Parámetros:
//   - saldo: Saldo actual en la cuenta
// Retorna: Saldo actualizado después del depósito
// -------------------------------------------------------------------------
Funcion saldoActual <- abonarDinero ( saldo )
	
	Definir abonado, saldoActual Como Entero;
	
	Escribir "Ingrese dinero abonar: ";
	Leer abonado;
	
	//Validación de monto mínimo
	Si abonado < 1 Entonces
		Escribir "No puede abonar un saldo inferiror a $1";
		saldoActual = saldo;
	SiNo
		saldoActual = saldo + abonado;
		Escribir "Dinero abonado, su saldo actual es: ", saldoActual;
	FinSi
Fin Funcion

// -------------------------------------------------------------------------
// Función: mostrarMenu
// Descripción: Muestra el menú principal de opciones y captura la selección
// Parámetros:
//   - x: Parámetro de control (no utilizado actualmente)
// Retorna: Opción seleccionada por el usuario
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
// Función: mostrarSaldo
// Descripción: Muestra el saldo actual al usuario
// Parámetros:
//   - saldo: Saldo actual en la cuenta
// -------------------------------------------------------------------------
Funcion  mostrarSaldo (saldo)

	Escribir "Su saldo actual es: $", saldo;
	Escribir "Presione una tecla para continuar..";
	Esperar Tecla;
Fin Funcion

// -------------------------------------------------------------------------
// Función: mostrarBienvenida
// Descripción: Gestiona el proceso de autenticación del usuario
// Parámetros:
//   - pinDefault: PIN predeterminado del sistema
// Retorna: Verdadero si la autenticación es exitosa, Falso en caso contrario
// -------------------------------------------------------------------------
Funcion validado <- mostrarBienvenida(pinDefault)
	
	Definir rutDefault Como Entero;
	Definir rut,pin Como Entero;
	Definir intentos Como Entero;
	Definir validado Como Logico;
	
	//Inicialización de variables de control
	validado = falso;
	intentos = 0;
	rutDefault = 12345678;
	pinDefault = pinDefault;

	Escribir "Bienvenido a nuestro cajero automatico";
	Escribir FechaActual();
	Escribir "Por favor ingrese su RUT y PIN";
	Escribir "Digite su RUT:";
	Leer rut;
	
	// Validación de RUT y PIN
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
		Escribir "RUT INCORRECTO, TRANSACCIÓN FALLIDA.";
	FinSi
	
	//Mensaje en caso de exceder intentos de PIN.
	Si NO validado Y intentos = 3 Entonces
		Escribir "Ha excedido el número máximo de intentos";
	FinSi
Fin Funcion

// =========================================================================
// Algoritmo Principal: cajero_OttonLucena
// Descripción: Punto de entrada principal del sistema que coordina todas
//              las operaciones del cajero automático
// =========================================================================
Algoritmo cajero_OttonLucena
	// Declaración de variables principales
	Definir elegido Como Logico;
	Definir menu, saldoInicial, pinDefault, nuevoPin Como Entero;
	
	// Inicialización de valores por defecto
	pinDefault = 1234;
	saldoInicial= 10000;
	
	// Proceso de autenticación
	elegido <- mostrarBienvenida(pinDefault);
	
	// Bucle principal del programa
	Repetir
		Si elegido Entonces
			menu = mostrarMenu(menu);
		FinSi
		
		// Gestión de opciones del menú
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
