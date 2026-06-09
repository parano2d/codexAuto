# QR출석체크 Firebase DB 구조

## 최신 운영 구조

```text
/
├─ appState
│  ├─ activeYear
│  └─ activeCohortId
├─ forceLogout
├─ opts
└─ years
   └─ {year}
      ├─ meta
      ├─ roster
      └─ cohorts
         └─ {cohortId}
            ├─ name
            ├─ locked
            ├─ ended
            ├─ students
            └─ sessions
               └─ {sessionId}
                  ├─ title
                  ├─ cohortId
                  ├─ cohortName
                  ├─ year
                  ├─ openedAt
                  ├─ closedAt
                  └─ records
```

## 조건부 생성 노드

활성 출석 세션이 있을 때:

```text
/session
```

예약 세션이 있을 때:

```text
/years/{year}/scheduled
```

## 삭제 주의

삭제하면 안 되는 핵심 노드:

- `appState`
- `forceLogout`
- `opts`
- 운영 중인 `years/{activeYear}`
- 운영 중인 활성 기수
- 진행 중인 `/session`

## 레거시 노드

최신 구조에서는 아래 루트 노드는 사용하지 않습니다.

```text
/cohorts
/history
/roster
```

이 노드가 다시 생긴다면 이전 배포본이 실행 중이거나, 구버전 코드가 데이터를 쓴 것일 수 있습니다.
