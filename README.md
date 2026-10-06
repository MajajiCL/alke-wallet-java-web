# Alke Wallet - Java Dynamic Web Project (MVC + JSP)

**Evaluación Módulo #5: Arquitectura y Ciclo de Vida de Componentes**  
*Bootcamp: Desarrollo de Aplicaciones (SENCE / Alkemy)*

Repositorio Oficial: [https://github.com/VannePulgar/alke-wallet-java-web](https://github.com/VannePulgar/alke-wallet-java-web)

---

## 📋 Descripción del Proyecto

**Alke Wallet** es una aplicación web dinámica desarrollada en **Java EE** bajo el patrón de arquitectura **Modelo-Vista-Controlador (MVC)**, utilizando **JSP (JavaServer Pages)** para el frontend y **Servlets Java** para la lógica de negocio en el backend.

El objetivo central de este proyecto es implementar la **administración completa de fondos**:
1. Visualización de saldo total disponible en tiempo real.
2. Realización de depósitos de fondos.
3. Realización de retiros de fondos con validación de saldo.
4. Historial dinámico de transacciones.

---

## 🏛️ Arquitectura MVC (Model - View - Controller)

El proyecto sigue una estricta separación de responsabilidades:

```text
alke-wallet-java-web/
├── src/main/java/com/alkewallet/
│   ├── model/                  # MODELO: Entidades de datos y reglas de negocio
│   │   ├── User.java           # Representación del usuario
│   │   ├── Account.java        # Cuenta financiera, saldo y operaciones
│   │   └── Transaction.java    # Registro de transacciones (DEPOSIT / WITHDRAWAL)
│   ├── service/                # SERVICIOS: Capa lógica y persistencia en memoria
│   │   └── WalletService.java  # Singleton de gestión de fondos y autenticación
│   └── controller/             # CONTROLADOR: Servlets HTTP
│       ├── LoginServlet.java   # Manejo de inicio de sesión
│       ├── LogoutServlet.java  # Cierre de sesión e invalidación de estado
│       ├── HomeServlet.java    # Tablero principal de la wallet
│       ├── DepositServlet.java # Procesamiento de depósitos
│       ├── WithdrawServlet.java# Procesamiento de retiros con control de fondos
│       └── TransactionsServlet.java # Historial completo de movimientos
├── src/main/webapp/            # VISTAS (JSP) & ASSETS
│   ├── WEB-INF/
│   │   └── web.xml             # Descriptor de despliegue web
│   ├── css/
│   │   └── style.css           # Estilos corporativos Alke Wallet (Figma)
│   ├── index.jsp               # Redirección inicial
│   ├── login.jsp               # Vista de login con alertas de error
│   ├── home.jsp                # Tablero principal: saldo, acciones y transacciones
│   ├── deposit.jsp             # Formulario de depósito de fondos
│   ├── withdraw.jsp            # Formulario de retiro de fondos
│   └── transactions.jsp        # Vista del historial completo
├── pom.xml                     # Configuración Maven
└── README.md
```

---

## ⚙️ Funcionalidades Implementadas

### 1. Administración de Fondos
* **Consulta de Saldo:** Visualización destacada en el tablero principal (`$124.57` inicial para el usuario de demo).
* **Depósitos:** Formulario para ingresar montos válidos con actualización inmediata del saldo y registro en el historial.
* **Retiros:** Formulario de retiro con validación de saldo disponible (impide retiros mayores al balance o montos menores a cero).

### 2. Historial de Transacciones
* Cada operación genera un registro con fecha, hora, concepto, tipo de movimiento y monto formateado (`+$XX.XX` en verde para depósitos, `-$XX.XX` en rojo para retiros).

### 3. Autenticación y Sesiones
* Manejo de sesión con `HttpSession` para proteger el acceso a las vistas.
* Cierre seguro de sesión con `LogoutServlet`.

---

## 🔑 Credenciales de Prueba

Para ingresar a la aplicación:
* **Correo:** `amanda@alkewallet.com` o `vanne@alkewallet.com`
* **Contraseña:** `1234`

---

## 🚀 Cómo Ejecutar el Proyecto

### Opción 1: En Eclipse IDE for Enterprise Java (Dynamic Web Project)
1. Abrir **Eclipse IDE**.
2. Ir a **File > Import > General > Existing Projects into Workspace**.
3. Seleccionar la carpeta raíz del proyecto `alke-wallet-java-web`.
4. Hacer clic derecho sobre el proyecto > **Run As > Run on Server** (seleccionando Apache Tomcat 9 o superior).
5. La aplicación abrirá automáticamente en `http://localhost:8080/alke-wallet-java-web/`.

### Opción 2: Con Apache Maven
1. En la terminal dentro de la carpeta del proyecto:
   ```bash
   mvn clean package
   ```
2. Desplegar el archivo `.war` generado en la carpeta `webapps/` de tu servidor Tomcat.
