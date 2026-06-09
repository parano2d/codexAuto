# QR출석체크 프로젝트 상태

## 프로젝트

- 이름: 과학해설사 QR체크 출석프로그램
- 현재 배포: https://qrcheck1.netlify.app/
- 현재 운영 방식: `index.html` 단일 정적 앱 + Firebase Realtime Database/Auth
- 실제 작업 파일: 루트 `index.html`
- 관련 자산: 루트 `logo_black.svg`, `logo_white.svg`

## 현재 운영 판단

- 현재 기수 운영 중에는 기능 안정성을 우선합니다.
- Firebase 보안 강화, Cloud Functions, Render 이전은 운영 종료 후 테스트 환경에서 진행합니다.
- 개발자도구 차단은 핵심 보안수단이 아니므로 현재 운영 중 강제 적용하지 않습니다.

## 현재 확인된 핵심 상태

- 활성 연도: `2026`
- 활성 기수: `제44기`
- 학생 로그인은 활성 연도/활성 기수의 명단 기준으로만 허용되어야 합니다.

## 주요 구현 완료 사항

- 연도 > 기수 > 회차 구조 반영
- 기수별 명단관리
- 교육종료/잠금/잠금해제
- 기록/통계의 연도/기수/회차 종속
- 기수별 기록 삭제, 회차별 기록 삭제
- 학생 로그인 5분 유효성 체크
- 학생 출석 후 본인 출석현황 반영
- QR 카메라 확대 기능
- 관리자 활성 세션 종료 타이머
- 동명이인 표시용 휴대전화 뒷자리 보조 표시

## 보류 중인 큰 작업

- Firebase Rules 보안 강화
- Firebase Cloud Functions 적용 검토
- Render 유료 서버 + PostgreSQL 통합 이전 검토
- 과학해설사 운영 자동화 통합 시스템 설계

## Codex 작업 원칙

QR출석체크 프로젝트 작업 시 Codex는 아래 문서를 먼저 읽습니다.

1. 루트 `START_HERE.md`
2. 루트 `docs/GLOBAL_RULES.md`
3. 루트 `docs/HANDOFF_LOG.md`
4. 루트 `docs/CROSS_PC_WORKFLOW.md`
5. `projects/qr-attendance/PROJECT_STATUS.md`
6. `projects/qr-attendance/DB_STRUCTURE.md`
7. `projects/qr-attendance/DEPLOY_GUIDE.md`
8. `projects/qr-attendance/SECURITY_PLAN.md`
