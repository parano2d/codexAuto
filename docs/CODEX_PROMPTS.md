# Codex에게 붙여넣을 명령문 모음

이 문서는 전역 명령문만 다룹니다.
특정 프로젝트 명령은 `projects/{project-id}` 아래 문서 기준으로 추가해서 사용합니다.

## 다른 PC에서 처음 시작할 때

```text
GitHub 저장소 parano2d/codexAuto를 기준으로 작업을 이어받고 싶습니다.
START_HERE.md와 루트 docs 폴더의 전역 문서를 먼저 읽어주세요.
특히 GLOBAL_RULES.md, HANDOFF_LOG.md, CROSS_PC_WORKFLOW.md, PROJECTS.md를 기준으로
전역 작업 규칙, 마지막 작업 현황, 프로젝트 목록을 요약해주세요.
이후 제가 지정하는 projects/{project-id} 문서를 읽고 이어서 작업해주세요.
```

## 작업 시작

```text
작업 맥락 불러오기 절차를 진행해줘.
scripts/load-work.ps1을 실행한 뒤
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, docs/CHAT_HANDOFF.md를 읽고
현재 전역 작업 맥락을 파악해줘.
실제 파일 작업이 필요하면 프로젝트 루트를 나에게 먼저 물어봐.
```

## 특정 프로젝트 작업 시작

```text
프로젝트 파일 작업이 필요합니다.
실제 프로젝트 루트 폴더가 어디인지 나에게 먼저 물어보고,
확인된 루트 안에서만 파일을 읽거나 수정해줘.
```

## QR출석체크 프로젝트 작업 시작 예시

```text
projects/qr-attendance/PROJECT_STATUS.md,
projects/qr-attendance/DB_STRUCTURE.md,
projects/qr-attendance/DEPLOY_GUIDE.md,
projects/qr-attendance/SECURITY_PLAN.md를 읽고
QR출석체크 프로젝트의 현재 상태와 주의사항을 요약해줘.
```

## 작업 종료

```text
작업 종료 전 인수인계 정리를 해줘.
이번 대화에서 결정된 사항, 보류한 사항, 다음 PC에서 이어받을 내용을 요약한 뒤
scripts/save-work.ps1을 실행해서 GitHub parano2d/codexAuto에 마지막 작업 맥락을 업데이트해줘.
```

## 기존 PC 세션과 GitHub 세션 통합

```text
작업 맥락 통합을 진행해줘.
현재 PC의 기존 Codex 세션은 삭제하지 말고,
GitHub parano2d/codexAuto의 세션과 병합한 뒤 다시 GitHub에 올려줘.
scripts/merge-work.ps1을 사용해줘.
```

## GitHub 플러그인만 연결된 Codex에게

```text
GitHub 저장소 parano2d/codexAuto를 확인해 주세요.
저장소의 START_HERE.md와 루트 docs 폴더 문서를 읽고
이 저장소의 전역 작업 연동 방식과 마지막 작업 현황을 요약해 주세요.
로컬 파일 접근이 필요한 작업인지, GitHub 파일 수정만으로 가능한 작업인지 구분해서 알려주세요.
```
