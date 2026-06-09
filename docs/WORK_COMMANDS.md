# Codex 작업 맥락 불러오기/저장하기 명령

이 문서는 A/B/C 어느 컴퓨터에서든 같은 방식으로 Codex 원본 세션 파일과 작업 맥락을 이어받기 위한 전역 명령입니다.

실제 프로젝트 파일이나 폴더는 자동으로 동기화하지 않습니다.
동기화 대상은 `~/.codex/sessions`의 원본 세션 파일입니다.
파일 작업이 필요하면 Codex가 사용자에게 실제 프로젝트 루트를 따로 물어봐야 합니다.

## 전제 조건

- Git 설치
- GitHub 로그인
- Codex GitHub 플러그인 연결
- `parano2d/codexAuto` 저장소 접근 가능

## 1. 작업 맥락 불러오기

PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

기본값은 `merge` 모드입니다. 즉, 현재 PC의 기존 Codex 세션을 지우지 않고 GitHub 세션을 추가합니다.

현재 PC의 세션을 GitHub 기준으로 덮어맞추고 싶을 때만:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1 -Mode replace
```

그 다음 Codex에게:

```text
START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md,
docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md를 읽고
전역 작업 규칙, 프로젝트 목록, 마지막 대화/작업 맥락을 요약해줘.
실제 파일 작업이 필요하면 프로젝트 루트를 나에게 먼저 물어봐.
```

특정 프로젝트를 이어서 작업하려면:

```text
projects/{project-id} 문서를 읽고 해당 프로젝트를 이어서 작업해줘.
```

## 2. 작업 맥락 저장하기

PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Update handoff" -Note "작업 내용 요약"
```

## 3. 작업 맥락 통합하기

사무실 PC에 기존 Codex 세션이 있고, GitHub에 노트북에서 올린 세션도 있을 때 사용합니다.
기존 세션을 삭제하지 않고 양쪽 세션을 합친 뒤 다시 GitHub에 올립니다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\merge-work.ps1 -Message "Merge office Codex sessions" -Note "사무실 PC 기존 세션과 GitHub 세션 통합"
```

통합 과정:

```text
1. GitHub 최신 codexAuto pull
2. GitHub 세션을 현재 PC ~/.codex/sessions에 merge import
3. 현재 PC의 합쳐진 ~/.codex/sessions를 codexAuto로 export
4. commit/push
```

이 명령은 아래 작업을 자동으로 수행합니다.

```text
1. HANDOFF_LOG에 대화/판단 맥락 요약
2. ~/.codex/sessions 원본 세션 파일을 codex-sessions/sessions로 복사
3. LAST_SYNC 스냅샷 갱신
4. git add
5. git commit
6. git push
```

## 3. Codex에게 말로 요청할 때

작업 시작:

```text
작업 맥락 불러오기 절차를 진행해줘.
scripts/load-work.ps1을 실행한 뒤 글로벌 문서와 마지막 인수인계 로그를 읽고 요약해줘.
실제 프로젝트 루트가 필요하면 나에게 물어봐.
```

작업 종료:

```text
작업 맥락 저장하기 절차를 진행해줘.
이번 대화의 핵심 결정, 보류사항, 다음 PC에서 이어받을 내용을 요약해서
scripts/save-work.ps1을 실행하고 GitHub parano2d/codexAuto에 업데이트해줘.
```
