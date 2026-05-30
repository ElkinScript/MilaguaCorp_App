## ─────────────────────────────────────────────────────────────────────────────
## Milagua Corp — Flutter App  (Git Bash)
##
##   make build-env   ← regenera env.g.dart + freezed
##   make run-dev     ← corre en dispositivo conectado
##   make apk-dev     ← APK debug
##   make apk-prod    ← APK release
##   make install     ← build + instala por ADB
##   make clean       ← limpia caché
##   make rebuild     ← clean + build-env + apk-dev
## ─────────────────────────────────────────────────────────────────────────────

SHELL   := C:/Program Files/Git/bin/bash.exe
.SHELLFLAGS := -c

FLUTTER := C:/Users/ELKIN_MOYON/fvm/versions/3.35.0/bin/flutter.bat
ADB     := adb

# ─────────────────────────────────────────────────────────────────────────────
# Codegen — env.g.dart + freezed
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: build-env
build-env:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) pub get
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) pub run build_runner build --delete-conflicting-outputs

.PHONY: watch-env
watch-env:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) pub run build_runner watch --delete-conflicting-outputs

# ─────────────────────────────────────────────────────────────────────────────
# Run
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: run-dev
run-dev:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) run -t lib/main/main_dev.dart

.PHONY: run-prod
run-prod:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) run -t lib/main/main_prod.dart

# ─────────────────────────────────────────────────────────────────────────────
# Build APK
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: apk-dev
apk-dev:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) build apk -t lib/main/main_dev.dart --debug
	@echo ""
	@echo "APK: build/app/outputs/flutter-apk/app-debug.apk"

.PHONY: apk-prod
apk-prod:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) build apk -t lib/main/main_prod.dart --release
	@echo ""
	@echo "APK: build/app/outputs/flutter-apk/app-release.apk"

# ─────────────────────────────────────────────────────────────────────────────
# Instalar en dispositivo USB (requiere ADB en PATH)
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: install
install: apk-dev
	$(ADB) install -r build/app/outputs/flutter-apk/app-debug.apk

.PHONY: install-prod
install-prod: apk-prod
	$(ADB) install -r build/app/outputs/flutter-apk/app-release.apk

# ─────────────────────────────────────────────────────────────────────────────
# Limpieza
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: clean
clean:
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) clean
	PROCESSOR_ARCHITECTURE=AMD64 $(FLUTTER) pub get

# ─────────────────────────────────────────────────────────────────────────────
# Rebuild completo
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: rebuild
rebuild: clean build-env apk-dev
