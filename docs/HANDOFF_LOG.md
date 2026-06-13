# 인수인계 로그

이 파일은 노트북, 사무실 PC, 집 PC 사이에서 Codex 작업 맥락을 이어가기 위한 전역 로그입니다.

특정 프로젝트 상세 내용은 이 파일에 길게 적지 않고, `projects/{project-id}` 아래 문서를 기준으로 관리합니다.

작업 종료 시 아래 명령을 실행하면 새 항목이 자동으로 추가됩니다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\update-handoff.ps1
```

## 현재 기준

- 루트 문서는 전역 규칙만 다룹니다.
- 프로젝트별 세부 내용은 `projects/{project-id}` 아래에 둡니다.
- 새 컴퓨터에서 Codex는 먼저 `START_HERE.md`와 루트 `docs` 문서를 읽어야 합니다.

---

## 2026-06-09 / 전역 자동화 구조 정리

- GitHub 대상 저장소: `https://github.com/parano2d/codexAuto`
- 전역 문서: `START_HERE.md`, `docs/GLOBAL_RULES.md`, `docs/CROSS_PC_WORKFLOW.md`
- 프로젝트 목록: `docs/PROJECTS.md`
- QR출석체크 프로젝트 문서: `projects/qr-attendance`

다음 컴퓨터에서 Codex에게 요청할 말:

```text
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md를 읽고
전역 작업 규칙과 프로젝트 목록을 파악해줘.
```

---

## 2026-06-09 16:44:56 +09:00 / 사론-MSI

- Root: C:\Users\사론\OneDrive\바탕 화면\출석프로그램
- index.html: 173448 bytes / 2026-06-09 15:36:30
- SHA256: 2164C7C68C2797B01E329037720DC01D64201281F543AAB70754DE116974DDD1
- Memo: global rules separated from qr-attendance project details

Next Codex prompt:
Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, and docs/PROJECTS.md.
Then summarize global rules, project list, and the latest handoff.

---

## 2026-06-09 17:07:35 +09:00 / 사론-MSI

- Root: C:\Users\사론\OneDrive\바탕 화면\출석프로그램
- Snapshot: .codex-handoff/LAST_SYNC.md
- Memo: setup-github push

Next Codex prompt:
Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md.
Then summarize the latest Codex work context. Ask for the project root only if file work is needed.

---

## 2026-06-11 16:00:00 +09:00 / 사론-MSI

- Root: C:\Users\사론\OneDrive\바탕 화면\출석프로그램
- Snapshot: .codex-handoff/LAST_SYNC.md
- Memo: Implemented low-token hash-based startup sync, first setup, upload, download, and merge automation; isolated round-trip tests passed.

Next Codex prompt:
Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md.
Then summarize the latest Codex work context. Ask for the project root only if file work is needed.

---

## 2026-06-11 16:00:24 +09:00 / 사론-MSI

- Root: C:\Users\사론\OneDrive\바탕 화면\출석프로그램
- Snapshot: .codex-handoff/LAST_SYNC.md
- Memo: Automatic session upload from 사론-MSI

Next Codex prompt:
Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md.
Then summarize the latest Codex work context. Ask for the project root only if file work is needed.

---

## 2026-06-11 16:28:31 +09:00 / 사론-MSI

- Root: C:\Users\사론\OneDrive\바탕 화면\출석프로그램
- Snapshot: .codex-handoff/LAST_SYNC.md
- Memo: Finalized global commands: 최초세팅, 작업시작, 작업종료. Added AGENTS.md automatic command mapping and completed verification.

Next Codex prompt:
Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md.
Then summarize the latest Codex work context. Ask for the project root only if file work is needed.

---

## 2026-06-13 12:46:52 +09:00 / KSR_MAIN

- Root: C:\Users\KSR\Documents\Codex\2026-06-13\github-https-github-com-parano2d-codexauto\codexAuto
- Snapshot: .codex-handoff/LAST_SYNC.md
- Memo: Automatic non-conflicting session merge from KSR_MAIN

Next Codex prompt:
Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md.
Then summarize the latest Codex work context. Ask for the project root only if file work is needed.
