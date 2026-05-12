# claude-config

Claude Code 글로벌 skill 모음. 새 컴퓨터에서 셋업하면 모든 프로젝트에서 `/강사싱크`, `/시작`, `/노션메모`, `/노션정리`, `/푸쉬` 사용 가능.

---

## 새 컴퓨터 셋업 (한 번만)

```cmd
git clone https://github.com/jungwonil11-jpg/claude-config
cd claude-config
setup.bat
```

또는 파일 탐색기에서 `setup.bat` 더블클릭해도 됨.

레포 업데이트 후에도 `setup.bat` 다시 실행하면 최신 skill로 갱신됨.

---

## Skill 목록

| Skill | 설명 |
|--------|------|
| `/강사싱크` | 수업 끝난 직후 실행. 강사 코드를 main에 미러링하고 study에 머지. |
| `/시작` | 다른 컴퓨터에서 자습 시작 전 실행. study 브랜치를 최신 상태로 동기화. |
| `/노션메모` | 직전 대화에서 설명한 내용을 노션 학습 노트에 추가. |
| `/노션정리` | 프로젝트 전체를 파악해 노션을 동기화. 처음 실행 시 CLAUDE.md에 정리 방식 자동 기록. |
| `/푸쉬` | 현재 브랜치를 origin에 push. fetch → 충돌 분석 → 사용자 결정 → push. |

---

## 특정 프로젝트에서 skill 끄기

수업용 skill(`/강사싱크`, `/시작`)이 일반 프로젝트 메뉴에 뜨는 게 싫으면, 그 프로젝트에 `.claude/settings.local.json` 추가:

```json
{
  "skillOverrides": {
    "강사싱크": "off",
    "시작": "off"
  }
}
```

`.local.json` 은 보통 gitignore 되므로 팀원에게는 안 보이고 본인 PC에만 적용됨.

---

## 새 수업 프로젝트 시작할 때

**1. 프로젝트 repo의 `CLAUDE.md`에 강사 정보 추가**

```markdown
## 강사 정보
- upstream: https://github.com/강사계정/강사repo
```

**2. `/강사싱크` 실행** → CLAUDE.md에서 URL을 읽어 upstream 자동 등록

---

## /노션정리 사용할 때

처음 실행하면 Claude가 프로젝트 구조를 보고 정리 방식을 판단해 `CLAUDE.md`에 자동 기록함.

```markdown
## 노션 정리 방식
- 노션 상위 페이지: 🐍 Python 강의
- 하위 페이지 구성: day별
- 정리 기준: 코드 파일 기준
```

이후 실행부터는 `CLAUDE.md`를 읽어 그 방식대로 노션 동기화.
수정이 필요하면 `CLAUDE.md`의 해당 섹션을 직접 편집하면 됨.

---

## 팀 프로젝트에서 /푸쉬 사용할 때

프로젝트 `CLAUDE.md`에 아래 두 줄 추가:

```markdown
## 브랜치 정보
- my-branch: 내브랜치명
- integration-branch: dev
```

`/푸쉬` 실행 시 CLAUDE.md에서 자동으로 읽어옴.

---

## 브랜치 전략 (수업 프로젝트)

| 브랜치 | 역할 |
|--------|------|
| `main` | 강사 코드 미러. 직접 작업 금지. |
| `study` | 자습·실습·주석 작업 공간. |

- `.claude/`, `CLAUDE.md`, `CLAUDE.local.md` 는 `study` 에만 존재 (`main` commit 금지)
- `study` 브랜치에서 `.claude/` 파일 수정 시 `git add -f .claude/` 필요
