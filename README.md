# 🛝 MLOPS-PLAYGROUND

[![O'Reilly](https://img.shields.io/badge/O'Reilly-Practical%20MLOps-D3002D?logo=oreilly&logoColor=white)](https://www.oreilly.com/library/view/practical-mlops/9781098103002/)
[![Upstream](https://img.shields.io/badge/Upstream-paiml%2Fpractical--mlops--book-181717?logo=github&logoColor=white)](https://github.com/paiml/practical-mlops-book)
[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white)](https://www.python.org/)

*Practical MLOps (Noah Gift & Alfredo Deza, O'Reilly 2021)* 를 따라가며 실습하는 개인 학습 공간입니다.  
업스트림 코드는 `01_upstream/` 에서 읽기 전용으로 참조하고 모든 실습 코드는 `02_workspace/` 에 직접 작성합니다.

---

## ⚡ Quick Start

```bash
# 1. 클론 & 업스트림 초기화
git clone https://github.com/<your-id>/MLOPS-PLAYGROUND.git && cd MLOPS-PLAYGROUND
make upstream-init      # 01_upstream/ 에 원본 repo 클론 (최초 1회)

# 2. Python 환경 셋업
make setup              # .venv 생성 + requirements.txt 설치

# 3. 코드 품질 확인
make format && make lint && make test

# 4. 챕터 실행
make chapter=chapter2 run
```

---

## 📋 진행 상황

| # | 챕터 | 주제 | 진행 |
|---|------|------|:----:|
| 1  | `chapter1`  | Introduction to MLOps (노트 전용)    | ⬜ |
| 2  | `chapter2`  | MLOps 기초 & 자동화 파이프라인       | ⬜ |
| 3  | `chapter3`  | CML (Continuous Machine Learning)    | ⬜ |
| 4  | `chapter4`  | 컨테이너 패키징 & 배포               | ⬜ |
| 5  | `chap05`    | AutoML & Ludwig                      | ⬜ |
| 6  | `chapter6`  | 모니터링 & 로깅                      | ⬜ |
| 7  | `chapter7`  | MLOps on AWS                         | ⬜ |
| 10 | `chapter10` | MLOps on Azure                       | ⬜ |
| 11 | `chapter11` | MLOps on GCP                         | ⬜ |

> ⬜ 시작 전 · 🔄 진행 중 · ✅ 완료 · ⏸ 보류

---

## 📁 디렉토리 구조

```
MLOPS-PLAYGROUND/
├── 01_upstream/          # 원본 코드 (git submodule, read-only)
├── 02_workspace/         # 내 실습 코드
│   ├── chapter2/
│   │   ├── src/main.py   # 챕터 진입점
│   │   ├── tests/
│   │   └── README.md     # 챕터별 메모
│   └── ...
├── .gitignore
├── Makefile
├── requirements.txt
└── README.md
```

---

## 🛠 Makefile 타겟

| 명령어 | 설명 |
|--------|------|
| `make setup` | `.venv` 생성 + 의존성 설치 |
| `make format` | black 포맷팅 |
| `make lint` | pylint 검사 |
| `make test` | pytest + 커버리지 |
| `make chapter=<ch> run` | 챕터 진입점 실행 |
| `make upstream-init` | submodule 최초 추가 |
| `make upstream-update` | submodule 최신화 |
| `make clean` | venv / 캐시 삭제 |

---

## 📌 참고 링크

- [paiml/practical-mlops-book](https://github.com/paiml/practical-mlops-book) — 업스트림 원본
- [O'Reilly 도서 페이지](https://www.oreilly.com/library/view/practical-mlops/9781098103002/)
- [MLflow 공식 문서](https://mlflow.org/docs/latest/index.html)
