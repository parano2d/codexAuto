# 명령어 기준표

이 문서는 모든 Codex가 공통으로 따라야 하는 명령어 기준입니다.

빈 Codex는 이 문서를 읽은 뒤, 사용자가 짧게 말하는 명령을 아래 절차로 해석합니다.

## 1. 최초세팅

사용자 명령:

```text
최초세팅!
```

별칭:

```text
최소세팅!
```

목적:

```text
어떤 PC에서든 codexAuto 저장소를 준비하고, 이후 명령 체계를 이해합니다.
```

Codex가 할 일:

```text
1. GitHub 저장소 https://github.com/parano2d/codexAuto 를 확인합니다.
2. 로컬에 저장소가 없으면 clone합니다.
3. 로컬에 저장소가 있으면 pull 합니다.
4. README.md, START_HERE.md, docs/COMMAND_REFERENCE.md, docs/WORK_COMMANDS.md를 읽습니다.
5. `scripts/first-setup.ps1`을 실행합니다.
6. 바탕화면에 `Codex 동기화 실행` 바로가기를 만듭니다.
7. 사용 가능한 명령어를 사용자에게 요약합니다.
```

주의:

```text
실제 프로젝트 파일 루트는 자동 추정하지 않습니다.
파일 작업이 필요할 때만 사용자에게 루트를 물어봅니다.
```

## 2. 동기화 확인

사용자 명령:

```text
동기화 확인!
```

Codex가 실행할 명령:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\auto-sync.ps1
```

판정은 원본 채팅 내용을 모델이 읽지 않고 파일 경로, SHA256, 크기, 마지막 동기화 해시만 사용합니다.

```text
동일       → 아무 작업 없음
로컬 최신  → 자동 올리기
클라우드 최신 → 자동 내려받기
양쪽 별도 변경 → 자동 병합
같은 세션 충돌 → 원본 보존 후 사용자 확인
```

## 3. 올리기

사용자 명령:

```text
올리기!
```

목적:

```text
현재 PC의 Codex 원본 세션 파일을 GitHub에 업로드합니다.
```

Codex가 실행할 명령:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\save-work.ps1 -Message "Update Codex sessions" -Note "Codex session upload"
```

작동 로직:

```text
1. 현재 PC의 ~/.codex/sessions 원본 세션 파일을 codexAuto/codex-sessions/sessions로 복사합니다.
2. MANIFEST를 갱신합니다.
3. HANDOFF_LOG와 LAST_SYNC를 갱신합니다.
4. git add / commit / push를 실행합니다.
5. GitHub의 codexAuto가 최신 세션 상태가 됩니다.
```

## 4. 내려받기

사용자 명령:

```text
내려받기!
```

목적:

```text
GitHub에 저장된 Codex 세션을 현재 PC의 Codex 세션 폴더로 가져옵니다.
기본값은 기존 로컬 세션을 삭제하지 않는 merge입니다.
```

Codex가 실행할 명령:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1
```

작동 로직:

```text
1. GitHub codexAuto 최신 상태를 pull 합니다.
2. 현재 PC의 기존 ~/.codex/sessions를 codex-session-backups에 백업합니다.
3. codexAuto/codex-sessions/sessions 파일을 ~/.codex/sessions로 병합 복사합니다.
4. 기존 로컬 세션은 삭제하지 않습니다.
5. 필요하면 Codex를 재시작해 세션 목록 표시를 확인합니다.
```

금지:

```text
사용자가 명시하지 않는 한 replace 모드를 사용하지 않습니다.
기존 로컬 Codex 세션을 삭제하지 않습니다.
```

## 5. 병합하기

사용자 명령:

```text
병합하기!
```

기존 별칭 `통합하기!`도 같은 의미로 처리합니다.

목적:

```text
현재 PC의 기존 Codex 세션과 GitHub의 Codex 세션을 합친 뒤,
합쳐진 결과를 다시 GitHub에 업로드합니다.
```

Codex가 실행할 명령:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\merge-work.ps1 -Message "Merge Codex sessions" -Note "Codex session merge"
```

작동 로직:

```text
1. GitHub codexAuto 최신 상태를 pull 합니다.
2. 현재 PC의 기존 ~/.codex/sessions를 codex-session-backups에 백업합니다.
3. GitHub 세션을 현재 PC의 기존 Codex 세션에 merge import 합니다.
4. 병합된 ~/.codex/sessions 전체를 codexAuto/codex-sessions/sessions로 export 합니다.
5. git add / commit / push를 실행합니다.
6. 로컬과 GitHub 모두 병합된 최신 상태가 됩니다.
```

사용 추천 상황:

```text
사무실 PC처럼 기존 Codex 세션이 있고,
노트북/집컴에서 올린 GitHub 세션도 함께 합쳐야 할 때 사용합니다.
```

## 명령 선택 기준

```text
현재 PC 내용을 GitHub에 올리고 싶다
→ 올리기!

GitHub 내용을 현재 PC로 받고 싶다
→ 내려받기!

현재 PC와 GitHub 내용을 둘 다 합치고 싶다
→ 병합하기!

처음 쓰는 PC다
→ 최초세팅!
```
