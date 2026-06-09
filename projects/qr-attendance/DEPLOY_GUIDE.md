# QR출석체크 배포 가이드

## 현재 배포 방식

- 서비스: Netlify
- 배포 대상: `index.html`, `logo_black.svg`, `logo_white.svg`
- 현재 URL: https://qrcheck1.netlify.app/
- 서버: Firebase Realtime Database/Auth

## 배포 전 확인

1. `index.html` 최신 수정사항 확인
2. 관리자 로그인 확인
3. 학생 로그인 확인
4. 활성 세션 생성/종료 확인
5. QR 스캔 버튼과 출석하기 버튼 확인
6. 기록/통계에서 연도/기수/회차별 데이터 확인

## GitHub 사용 시

작업 종료 후:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\update-handoff.ps1
git add .
git commit -m "Update QR attendance program"
git push
```

다른 컴퓨터에서:

```powershell
git pull
```
