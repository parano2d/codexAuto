# QR출석체크 보안 개선 계획

## 현재 결론

현재 운영 중인 기수는 안정성을 우선하여 기존 구조를 유지합니다.

## 현재 위험

- Firebase Rules가 공개 상태라면 개발자도구나 외부 도구로 DB 접근이 가능합니다.
- 브라우저 코드에 Firebase URL이 포함되는 것은 정적 웹앱 특성상 완전히 숨길 수 없습니다.
- 개발자도구 차단은 보조 억제책일 뿐, 핵심 보안수단은 아닙니다.

## 운영 중 보류 항목

- Firebase Rules 비공개 전환
- Cloud Functions 적용
- Render 서버 이전
- 개발자도구 감지 후 강제 종료

## 기수 종료 후 권장 순서

1. Firebase 전체 JSON 백업
2. 테스트 연도/테스트 기수 생성
3. Firebase Rules 강화 실험
4. 학생 로그인/출석/QR/통계 흐름 테스트
5. Cloud Functions 방식 검토
6. Render 유료 서버 + PostgreSQL 통합 이전 검토
