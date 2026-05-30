# 📱 Milagua Corp — App Flutter

App móvil para empleados de ventas de Milagua Corp.
Gestión de ventas, productos, reportes y proformas.

**Desarrollado por:** Elkin Moyon — Ingeniero de Software

---

## 🏗️ Stack

- Flutter 3.35 + Dart
- Riverpod (estado) + GoRouter (navegación)
- Dio (HTTP) + Freezed (modelos) + envied (env vars)

---

## ⚙️ Requisitos

- Flutter via FVM: `C:/Users/ELKIN_MOYON/fvm/versions/3.35.0/bin/flutter.bat`
- Backend Milagua-Corp corriendo (ver su README)
- Android Studio o VS Code con extensión Flutter

---

## 🚀 Primera vez (setup completo)

```bash
cd milaguacorp

# 1. Instalar dependencias y generar env.g.dart
make build-env
```

---

## 🌐 Configurar URL del backend

Edita `.env.dev` con la IP del backend:

```env
# Dispositivo físico o emulador (misma red WiFi)
BASE_URL=http://192.168.0.108:8000

# Solo emulador Android
BASE_URL=http://10.0.2.2:8000
```

Después de cambiar `.env.dev`, regenera siempre:

```bash
make build-env
```

> Tu IP local: corre `ipconfig` en Windows y busca la IPv4 de tu red WiFi.

---

## ▶️ Correr la app

### Android Studio
- Run → Edit Configurations
- Target: `lib/main/main_dev.dart`
- Build Flavor: **vacío** (no poner nada)
- Presiona ▶️

### Terminal
```bash
make run-dev
```

---

## 🔧 Comandos

```bash
make build-env   # genera lib/core/env/env.g.dart (SIEMPRE antes de correr)
make run-dev     # corre en modo desarrollo
make run-prod    # corre en modo producción
make apk-dev     # build APK debug
make apk-prod    # build APK release
make clean       # limpia + reinstala dependencias
```

---

## 🗂️ Estructura del proyecto

```
lib/
├── core/
│   ├── env/
│   │   ├── env.dart       # definición envied
│   │   └── env.g.dart     # generado — NO subir al repo
│   └── flavors/
│       └── flavors_config.dart
├── feature/
│   ├── auth/              # login + JWT
│   ├── dashboard/         # pantalla principal
│   ├── sale/              # listado de ventas
│   ├── new_sale/          # nueva venta (bottom sheet)
│   ├── product/           # productos
│   ├── report/            # reportes
│   └── proforma/          # detalle de venta
├── main/
│   ├── common_main.dart
│   ├── main_dev.dart      # entry point desarrollo
│   └── main_prod.dart     # entry point producción
└── modules/
    └── common/
        └── drivers/
            ├── http/      # Dio + JWT interceptor
            └── storage/   # flutter_secure_storage
```

---

## 📝 Variables de entorno

| Archivo | Uso |
|---|---|
| `.env.dev` | URL del backend en desarrollo |
| `.env.prod` | URL del backend en producción |

Ambos están en `.gitignore` — cada desarrollador los crea en su máquina.

---

## 🖥️ Nuevo desarrollador

```bash
git clone <repositorio>
cd milaguacorp

# Crear .env.dev con la IP del backend
echo "BASE_URL=http://<ip-backend>:8000" > .env.dev

# Generar env.g.dart e instalar deps
make build-env

# Correr la app
make run-dev
```

**Credenciales de prueba:**
```
usuario:    admin
contraseña: admin123
```

---

## 🆘 Troubleshooting

### "Sin conexión. Verifica tu red" al hacer login

Si el login devuelve "sin conexión" desde un dispositivo físico (tablet/celular)
pero el backend responde bien desde el navegador del PC, casi siempre es una
de estas tres causas:

1. **Cleartext HTTP bloqueado por Android 9+** (la app intenta `http://...`
   y Android lo bloquea por defecto).
   - Fix: en `android/app/src/main/AndroidManifest.xml` la etiqueta
     `<application>` debe tener `android:usesCleartextTraffic="true"` y el
     manifest debe tener `<uses-permission android:name="android.permission.INTERNET"/>`.
   - **Hot reload NO recompila el manifest.** Hay que rebuild:

     ```bash
     make clean
     make build-env
     make run-dev
     ```

2. **`.env.dev` apunta a una IP equivocada** (cambió la IP LAN del PC).
   - Verifica con `ipconfig` (Windows) o `hostname -I` (WSL/Linux).
   - Actualiza `BASE_URL=http://<tu-ip>:8000` y regenera con `make build-env`.

3. **Dispositivo en otra red WiFi.**
   - Abre `http://<ip-backend>:8000` en el navegador del dispositivo.
   - Si no carga, conéctalo a la misma WiFi que el PC.

### Cambiar tamaño de dispositivo (tablet, móvil, PC) en debug

La app está envuelta en `device_preview_plus`. Al correr en modo debug
aparece un panel lateral donde puedes simular distintos tamaños de pantalla
sin tener que conectar tablets/celulares físicos cada vez. En release se
desactiva automáticamente.

### Logs de las llamadas HTTP

En modo debug, cada request a la API se imprime en la consola con formato:

```
────────────────────────────────────────
➡️  REQUEST  POST  http://192.168.0.113:8000/api/auth/token/
   Headers: {...}
   Body:    {"username":"admin","password":"admin123"}

────────────────────────────────────────
✅ RESPONSE 200  POST  http://192.168.0.113:8000/api/auth/token/
   Data:    {"access":"...","refresh":"...","user":{...}}
```

Esto está en `lib/modules/common/drivers/http/dio_http_client.dart`. En
release no se imprime nada.
