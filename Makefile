# ============================================================
# Practical MLOps 실습 Makefile
# macOS / Python venv 기반
# 사용 예:
#   make setup
#   make lint
#   make format
#   make test
#   make chapter=chapter2 run
# ============================================================

PYTHON      := python3
VENV_DIR    := .venv
VENV_BIN    := $(VENV_DIR)/bin
PIP         := $(VENV_BIN)/pip
PYLINT      := $(VENV_BIN)/pylint
BLACK       := $(VENV_BIN)/black
PYTEST      := $(VENV_BIN)/pytest

# 실행할 챕터 (기본값: chapter2)
chapter     ?= chapter2
CHAPTER_DIR := 02_workspace/$(chapter)

.PHONY: help setup lint format test run clean upstream-init upstream-update

# ── 기본 타겟 ────────────────────────────────────────────────
help:
	@echo ""
	@echo "  make setup               venv 생성 + 의존성 설치"
	@echo "  make lint                pylint 실행 (02_workspace 전체)"
	@echo "  make format              black 포맷팅 (02_workspace 전체)"
	@echo "  make test                pytest 실행 (02_workspace 전체)"
	@echo "  make chapter=<ch> run    특정 챕터 진입점 실행"
	@echo "  make upstream-init       git submodule 초기화"
	@echo "  make upstream-update     git submodule 최신 동기화"
	@echo "  make clean               venv / 캐시 삭제"
	@echo ""

# ── 환경 설정 ────────────────────────────────────────────────
setup:
	@echo "▶ Python venv 생성 중 → $(VENV_DIR)/"
	$(PYTHON) -m venv $(VENV_DIR)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo "✅ setup 완료. 활성화: source $(VENV_DIR)/bin/activate"

# ── 코드 품질 ────────────────────────────────────────────────
lint:
	@echo "▶ pylint 실행..."
	$(PYLINT) 02_workspace/ --recursive=yes \
	    --disable=C0114,C0115,C0116 \
	    --ignore=__pycache__ || true

format:
	@echo "▶ black 포맷팅..."
	$(BLACK) 02_workspace/

# ── 테스트 ───────────────────────────────────────────────────
test:
	@echo "▶ pytest 실행..."
	$(PYTEST) 02_workspace/ -v --tb=short \
	    --cov=02_workspace \
	    --cov-report=term-missing

# ── 챕터 실행 ────────────────────────────────────────────────
run:
	@echo "▶ $(chapter) 실행 중..."
	@if [ -f "$(CHAPTER_DIR)/src/main.py" ]; then \
	    $(VENV_BIN)/python $(CHAPTER_DIR)/src/main.py; \
	elif [ -f "$(CHAPTER_DIR)/main.py" ]; then \
	    $(VENV_BIN)/python $(CHAPTER_DIR)/main.py; \
	else \
	    echo "❌ 진입점 없음: $(CHAPTER_DIR)/src/main.py 를 생성해 주세요."; \
	    exit 1; \
	fi

# ── 업스트림 서브모듈 ────────────────────────────────────────
upstream-init:
	@echo "▶ 업스트림 submodule 초기화..."
	git submodule add https://github.com/paiml/practical-mlops-book.git 01_upstream
	git submodule update --init --recursive
	@echo "✅ 01_upstream/ 에 upstream repo 클론됨"

upstream-update:
	@echo "▶ 업스트림 최신화..."
	git submodule update --remote --merge 01_upstream
	@echo "✅ 업스트림 업데이트 완료"

# ── 정리 ─────────────────────────────────────────────────────
clean:
	rm -rf $(VENV_DIR)
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "mlruns" -exec rm -rf {} + 2>/dev/null || true
	find . -name "*.pyc" -delete 2>/dev/null || true
	@echo "✅ 정리 완료"
