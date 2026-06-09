# codexAuto

여러 컴퓨터에서 Codex 작업 대화와 판단 맥락을 이어받기 위한 글로벌 인수인계 자동화 저장소입니다.

이 저장소의 루트 문서는 모든 프로젝트에 공통으로 적용되는 규칙만 다룹니다.
실제 프로젝트 파일, 프로그램 소스, 배포 파일은 각 서비스의 저장소나 로컬 폴더에 따로 둡니다.

## 핵심 사용법

작업 시작 시 Codex에게:

```text
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md를 읽고
현재 글로벌 작업 규칙과 마지막 Codex 작업 맥락을 파악한 뒤 이어서 작업해줘.
```

또는 PowerShell에서:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

작업 종료 시 PowerShell에서:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Update handoff" -Note "작업 내용 요약"
```

## 목적

- 노트북, 사무실 PC, 집 PC 간 작업 상태 공유
- Codex 채팅 동기화 한계를 GitHub와 상태문서로 보완
- Codex 채팅 내역을 직접 동기화할 수 없는 한계를 요약/인수인계 로그로 보완
- 실제 작업 파일 위치는 매번 별도로 확인
- 프로젝트별 파일/폴더/클라우드 이전은 추후 별도 정리

## 포함 문서

- `START_HERE.md`: 새 PC에서 가장 먼저 읽을 안내문
- `docs/GLOBAL_RULES.md`: 모든 PC와 모든 프로젝트에 적용되는 전역 규칙
- `docs/HANDOFF_LOG.md`: 전역 작업 인수인계 로그
- `docs/CHAT_HANDOFF.md`: Codex 대화/판단 맥락 저장 기준
- `docs/CROSS_PC_WORKFLOW.md`: PC 간 이어받기 흐름
- `docs/CODEX_PROMPTS.md`: Codex에게 붙여넣을 명령문
- `docs/WORK_COMMANDS.md`: 작업 맥락 불러오기/저장하기 명령
- `docs/WORK_COMMANDS.md`: 작업환경 불러오기/저장하기 명령
- `docs/PROJECTS.md`: 프로젝트 목록, 실제 루트는 작업 시 별도 확인
