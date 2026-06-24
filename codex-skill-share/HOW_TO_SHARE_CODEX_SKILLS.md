# Codex 스킬 공유 방법

이 폴더는 여러 컴퓨터에서 같은 Codex 스킬과 최소 설정을 쓰기 위한 공유 폴더입니다.

## 처음 연결하는 컴퓨터

전체 repo를 다 받지 않고 Codex 공유 폴더만 받습니다.

```powershell
git clone --filter=blob:none --sparse https://github.com/seungH93/connect-ai.git codex-skill-checkout
cd codex-skill-checkout
git sparse-checkout set codex-skill-share
powershell -ExecutionPolicy Bypass -File .\codex-skill-share\install.ps1
```

끝나면 Codex를 재시작합니다.

## 이미 받아둔 컴퓨터

```powershell
cd codex-skill-checkout
git pull
powershell -ExecutionPolicy Bypass -File .\codex-skill-share\install.ps1
```

## 이 컴퓨터에서 스킬을 추가했을 때

로컬 Codex 스킬을 공유 폴더로 다시 내보냅니다.

```powershell
cd C:\Users\Seung\OneDrive\0.갓생을위한폴더\codex-skill-share
.\export.ps1
```

그 다음 repo 루트에서 공유 폴더만 올립니다.

```powershell
cd C:\Users\Seung\OneDrive\0.갓생을위한폴더
git add codex-skill-share
git commit -m "Update shared Codex skills"
git push
```

## 공유하는 것

- 개인 Codex 스킬: `codex-skill-share/skills`
- ponytail 같은 플러그인 등록 설정: `codex-skill-share/config`
- 설치 스크립트: `install.ps1`
- 내보내기 스크립트: `export.ps1`

## 공유하지 않는 것

- `auth.json`
- 로그인 정보
- 세션, 로그, memory sqlite
- plugin cache 전체
- 컴퓨터별 runtime 경로

이건 각 컴퓨터에서 따로 관리하는 게 안전합니다.
