# 여러 컴퓨터에서 Codex 이어받기

## 목표

노트북, 사무실 PC, 집 PC에서 같은 글로벌 저장소를 기준으로 Codex가 작업 상태를 이어받도록 합니다.

## 새 컴퓨터에서 최초 1회

1. Git 설치
2. GitHub 로그인
3. `parano2d/codexAuto` 저장소 clone
4. 저장소 폴더를 Codex에서 열기

## 매번 작업 시작

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

Codex에게:

```text
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md를 읽고 전역 상태를 파악해줘.
```

특정 프로젝트를 이어서 작업하려면:

```text
projects/{project-id} 아래 문서를 읽고 해당 프로젝트 상태를 파악해줘.
```

## 매번 작업 종료

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Update handoff" -Note "작업 내용 요약"
```

## 모바일 활용

모바일에서는 각 컴퓨터의 Codex 작업 상태를 확인하거나 승인 요청을 처리할 수 있습니다.

다만 여러 PC의 로컬 스레드가 자동으로 하나로 합쳐지는 것은 아니므로, 최종 기준은 GitHub와 이 저장소의 문서입니다.

## Codex가 항상 먼저 읽어야 하는 루트 파일

```text
START_HERE.md
docs/GLOBAL_RULES.md
docs/PROJECTS.md
docs/HANDOFF_LOG.md
docs/CROSS_PC_WORKFLOW.md
docs/CODEX_PROMPTS.md
docs/WORK_COMMANDS.md
```

## 프로젝트별로 추가로 읽을 파일

```text
projects/{project-id}/PROJECT_STATUS.md
projects/{project-id}/DB_STRUCTURE.md
projects/{project-id}/DEPLOY_GUIDE.md
projects/{project-id}/SECURITY_PLAN.md
```

## GitHub 플러그인만 연결된 Codex에게 요청할 말

```text
GitHub 저장소 parano2d/codexAuto를 확인해 주세요.
저장소의 START_HERE.md와 루트 docs 폴더 문서를 읽고
이 저장소의 전역 작업 연동 방식, 프로젝트 목록, 마지막 작업 현황을 요약해 주세요.
로컬 파일 접근이 필요한 작업인지, GitHub 파일 수정만으로 가능한 작업인지 구분해서 알려주세요.
```
