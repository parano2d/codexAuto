# 최초 세팅 명령

빈 Codex에서 처음 시작할 때 아래 문장을 그대로 입력합니다.

```text
최초세팅!

GitHub 저장소 https://github.com/parano2d/codexAuto 를 clone하거나,
이미 로컬에 있으면 최신 상태로 pull 해줘.

그 다음 README.md, START_HERE.md, docs/COMMAND_REFERENCE.md,
docs/WORK_COMMANDS.md를 읽고
앞으로 내가 사용할 명령어인 최초세팅, 동기화 확인, 올리기, 내려받기, 병합하기의
작동 방식을 요약해줘.

실제 프로젝트 파일 루트는 자동 추정하지 말고,
필요할 때 나에게 따로 물어봐.
```

## 전제 조건

- Git for Windows 설치 완료
- GitHub 플러그인 연결 완료
- GitHub 저장소 접근 가능

Codex가 저장소를 준비한 뒤 아래 스크립트를 실행합니다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\first-setup.ps1
```

이 스크립트는 바탕화면에 `Codex 동기화 실행` 바로가기를 만듭니다.
이후 일반 Codex 아이콘 대신 이 바로가기를 사용하면, Codex 실행 전에 GitHub와 세션 상태를 자동 비교하고 필요한 동기화를 수행합니다.

`최소세팅!`이라고 입력해도 `최초세팅!`과 같은 뜻으로 처리합니다.

## 최초 세팅 후 사용 명령

```text
동기화 확인!
올리기!
내려받기!
병합하기!
```

각 명령의 실제 작동 방식은 `docs/COMMAND_REFERENCE.md`를 기준으로 합니다.
