# Sistema de Cajero Automático 🏦

## Descripción
Sistema que simula las operaciones básicas de un cajero automático, implementando patrones de diseño y principios SOLID. El proyecto está desarrollado en pseudocódigo estructurado, demostrando buenas prácticas de programación y arquitectura de software.

### Características principales ⭐
- **Autenticación segura con RUT y PIN**
- Gestión de saldo (consultas, depósitos, retiros)
- Sistema de cambio de PIN con validaciones
- Control de intentos fallidos
- Interfaz de usuario mediante menú de opciones

---

## Arquitectura y Patrones de Diseño 🏗️

### **Single Responsibility Principle**
Cada función está diseñada con una única responsabilidad:
- `cambioPin()`: Gestión exclusiva de cambios de PIN
- `girarDinero()`: Procesamiento de retiros
- `abonarDinero()`: Manejo de depósitos
- `mostrarSaldo()`: Visualización de saldo

### **Facade Pattern**
- `mostrarMenu()`: Actúa como fachada, simplificando la interacción del usuario con el sistema.
  - Oculta la complejidad interna del sistema.
  - Proporciona una interfaz unificada.

### **State Pattern**
Gestión de estados del sistema:
- Estado de autenticación
- Estado de saldo
- Estado de PIN

---

## Estructura del Proyecto 📁
```plaintext
cajero_automatico/
│
├── funciones/
│   ├── autenticacion.psc     # Funciones de autenticación
│   ├── operaciones.psc       # Operaciones bancarias
│   └── validaciones.psc      # Validaciones del sistema
│
└── principal/
    └── cajero.psc            # Programa principal

```
---

## Funcionalidades Detalladas 🛠️

### Sistema de Autenticación
- Validación de **RUT**.
- Sistema de **PIN** con un máximo de 3 intentos.
- Bloqueo automático por seguridad tras superar el límite de intentos fallidos.

### Operaciones Bancarias
- **Consulta de Saldo:** Permite visualizar el saldo disponible.
- **Depósitos:** Solo permite abonos mayores o iguales a $1.
- **Retiros:** Realiza validaciones para:
  - Monto mínimo de $1.
  - No superar el saldo disponible.
- **Cambio de PIN:** Requiere:
  - Validar el PIN actual.
  - Confirmar el nuevo PIN ingresándolo dos veces.

---

## Requisitos del Sistema 💻
- **Software:** Compatible con PSeInt.
- **Versión mínima:** PSeInt 2020 o superior.

---

## Credenciales de Prueba
| **Dato**        | **Valor**       |
|------------------|-----------------|
| **RUT**         | `12345678`      |
| **PIN inicial** | `1234`          |
| **Saldo inicial** | `$10,000`     |

---

## Ejemplos de Uso 📝

### Consulta de Saldo
1. Ingresar el **RUT** y el **PIN** correcto.
2. Seleccionar la opción **1** del menú.
3. Visualizar el saldo actual en pantalla.

### Realizar un Depósito
1. Ingresar el **RUT** y el **PIN** correcto.
2. Seleccionar la opción **2** del menú.
3. Ingresar el monto deseado (mayor o igual a $1).
4. Confirmar la transacción para ver el saldo actualizado.

---

## Seguridad 🔒
- Bloqueo automático tras 3 intentos fallidos al ingresar el PIN.
- Validación de montos mínimos y máximos para transacciones.
- Verificación de saldo suficiente antes de realizar retiros.
- Cambio de PIN solo con confirmación exitosa.

---

## Autor ✒️
<table>
  <tr>
    <td align="center">
      <a href="https://github.com/ottonlucena">
        <img src="https://github.com/ottonlucena.png" width="100px;" alt="Foto de Otton Lucena"/><br>
        <sub>
          <b>Otton Lucena</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
