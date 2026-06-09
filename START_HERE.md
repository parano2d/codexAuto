# codexAuto 작업 시작 안내

이 저장소는 노트북, 사무실 PC, 집 PC에서 Codex 작업 대화와 판단 맥락을 이어받기 위한 글로벌 기준 저장소입니다.

루트 문서는 모든 프로젝트에 적용되는 전역 규칙만 다룹니다.
실제 프로젝트 파일과 폴더는 자동으로 정하지 않고, 작업할 때 사용자에게 별도로 확인합니다.

## Codex에게 처음 시킬 말

다른 컴퓨터에서 이 저장소를 열면 Codex에게 아래처럼 요청하세요.

```text
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, docs/CHAT_HANDOFF.md를 읽고
현재 글로벌 작업 규칙과 마지막 작업 맥락을 파악해줘.
실제 파일 작업이 필요하면 프로젝트 루트를 나에게 먼저 물어봐.
```

## 특정 프로젝트 파일 작업이 필요할 때

Codex는 실제 프로젝트 루트를 자동 추정하지 않습니다.
작업이 필요하면 사용자에게 먼저 위치를 묻습니다.

## 작업 종료 시 할 일

작업을 마치기 전에 PowerShell에서 아래 명령을 실행하세요.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Update handoff" -Note "작업 내용 요약"
```

이 명령은 인수인계 로그 갱신, commit, push까지 처리합니다.

## 작업 시작 시 할 일

PowerShell에서 아래 명령을 실행하세요.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

## 다른 컴퓨터에서 이어받기

GitHub를 사용하는 경우:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

그 다음 Codex에게:

```text
START_HERE.md와 docs 폴더의 글로벌 문서를 읽고,
마지막 HANDOFF_LOG.md 기준으로 현재 대화/작업 맥락을 요약해줘.
```

자세한 PC 간 연동 방식은 `docs/CROSS_PC_WORKFLOW.md`를 기준으로 합니다.
붙여넣기용 명령문은 `docs/CODEX_PROMPTS.md`에 정리되어 있습니다.
