# PC 간 Codex 작업 연동 흐름

이 문서는 노트북, 집 PC, 사무실 PC의 Codex가 같은 대화/판단 맥락을 이어받기 위한 전역 기준입니다.

특정 프로젝트의 파일, 폴더, 배포 환경은 이 문서에서 고정하지 않습니다.
실제 프로젝트 루트는 작업할 때마다 사용자에게 확인합니다.

## 핵심 원칙

Codex 채팅 자체는 PC마다 다를 수 있습니다.

따라서 작업 연동 기준은 아래 세 가지입니다.

```text
1. GitHub 저장소
2. 루트 docs 폴더의 전역 문서
3. docs/HANDOFF_LOG.md에 저장된 마지막 대화/작업 맥락
```

## 대상 GitHub 저장소

```text
https://github.com/parano2d/codexAuto
```

## 새 PC에서 최초 1회

GitHub 플러그인이 연결된 Codex에게 아래처럼 요청합니다.

```text
GitHub 저장소 parano2d/codexAuto를 기준으로 작업을 이어받고 싶습니다.
저장소를 확인한 뒤 START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/CODEX_PROMPTS.md, docs/PROJECTS.md를 읽고
전역 작업 규칙, 프로젝트 목록, 마지막 대화/작업 맥락을 요약해주세요.
실제 파일 작업이 필요하면 프로젝트 루트 폴더를 저에게 물어봐 주세요.
```

## 매번 작업 시작

작업 시작 시:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

그 다음 Codex에게:

```text
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md를 읽고
전역 작업 상태를 파악해줘.
```

특정 프로젝트 파일 작업이 필요할 때는 추가로:

```text
실제 프로젝트 루트 폴더가 어디인지 먼저 물어보고,
확인된 루트 안에서만 파일 작업을 진행해줘.
```

## 매번 작업 종료

작업 종료 시:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Update handoff" -Note "작업 내용 요약"
```

## 노트북에서 집 PC로 이동

노트북 작업 종료:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Notebook handoff" -Note "노트북 작업 종료"
```

집 PC 작업 시작:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

집 PC Codex에게:

```text
이 저장소는 노트북 Codex에서 이어받는 작업입니다.
START_HERE.md와 루트 docs 폴더의 전역 문서를 읽고 마지막 작업 현황을 요약해주세요.
실제 파일 작업이 필요하면 프로젝트 루트를 먼저 물어봐 주세요.
```

## 집 PC에서 사무실 PC로 이동

집 PC 작업 종료:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Home PC handoff" -Note "집 PC 작업 종료"
```

사무실 PC 작업 시작:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

사무실 PC Codex에게:

```text
이 저장소는 집 PC Codex에서 이어받는 작업입니다.
START_HERE.md와 루트 docs 폴더의 전역 문서를 읽고 마지막 작업 현황을 요약해주세요.
실제 파일 작업이 필요하면 프로젝트 루트를 먼저 물어봐 주세요.
```

## 충돌이 생겼을 때

아래 상황에서는 Codex에게 먼저 점검을 요청합니다.

```text
git pull 중 충돌이 발생했습니다.
충돌 파일을 확인하고 어떤 내용을 유지해야 하는지 판단해 주세요.
임의로 삭제하거나 되돌리지 말고, 먼저 충돌 내용을 요약해 주세요.
```

## Codex가 지켜야 할 전역 규칙

- 루트 문서에는 특정 프로젝트 전용 내용을 넣지 않습니다.
- 프로젝트별 실제 파일 루트는 자동 추정하지 않고 사용자에게 확인합니다.
- 운영 중인 서비스는 안정성을 우선합니다.
- 큰 구조 변경은 테스트 환경에서 검증한 뒤 적용합니다.
- 작업 시작 시 `scripts/load-work.ps1`로 최신 상태를 불러옵니다.
- 작업 종료 시 `scripts/save-work.ps1`로 마지막 상태를 GitHub에 저장합니다.
