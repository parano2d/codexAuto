# codexAuto Global Instructions

이 저장소는 여러 컴퓨터 사이에서 Codex 원본 세션을 동기화하기 위한 전역 자동화 저장소입니다.

## Main Commands

사용자가 아래 명령을 말하면 추가 설명 없이 해당 절차를 실행합니다.

- `최초세팅!` 또는 `최소세팅!`
  - `FIRST_SETUP.md`와 `docs/COMMAND_REFERENCE.md`를 읽습니다.
  - `scripts/first-setup.ps1`을 실행합니다.
- `작업시작!`
  - `scripts/auto-sync.ps1`을 실행합니다.
  - 동기화 결과만 간결하게 보고합니다.
- `작업종료!`
  - `scripts/save-work.ps1`을 실행해 현재 원본 세션을 commit/push 합니다.
  - 채팅 원문을 모델이 읽거나 요약하지 않습니다.

## Detailed Commands

- `동기화 확인!`: `scripts/sync-status.ps1`로 상태만 확인합니다.
- `올리기!`: `scripts/save-work.ps1`을 실행합니다.
- `내려받기!`: `scripts/load-work.ps1`을 실행합니다.
- `병합하기!` 또는 `통합하기!`: `scripts/merge-work.ps1`을 실행합니다.

## Boundaries

- 동기화 대상은 Codex 원본 세션이며, 실제 서비스 프로젝트 파일은 자동으로 포함하지 않습니다.
- 실제 프로젝트 파일 작업이 필요하면 사용자에게 해당 프로젝트 루트를 물어봅니다.
- 동일 세션 충돌 시 원본을 덮어쓰거나 삭제하지 않습니다.
- 세션 원문을 분석하지 않고 파일 해시와 Git 상태로 동기화를 판단합니다.
