# Codex 스킬 공유

Codex 스킬/설정 공유 폴더:

`codex-skill-share/`

자세한 사용법:

[codex-skill-share/HOW_TO_SHARE_CODEX_SKILLS.md](codex-skill-share/HOW_TO_SHARE_CODEX_SKILLS.md)

## 다른 컴퓨터에서 처음 연결

전체 repo를 다 받지 않고 Codex 공유 폴더만 받습니다.

```powershell
git clone --filter=blob:none --sparse https://github.com/seungH93/connect-ai.git codex-shared
cd codex-shared
git sparse-checkout set codex-skill-share
powershell -ExecutionPolicy Bypass -File .\codex-skill-share\install.ps1
```

끝나면 Codex를 재시작합니다.

## 이 컴퓨터에서 스킬을 추가했을 때

```powershell
cd C:\Users\Seung\OneDrive\0.갓생을위한폴더\codex-skill-share
.\export.ps1
cd ..
git add codex-skill-share CODEX_SKILL_SHARE.md
git commit -m "Update shared Codex skills"
git push
```

공유하지 않는 것: 로그인 정보, 세션, 로그, sqlite state, plugin cache 전체.
