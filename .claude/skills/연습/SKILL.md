---
name: 연습
description: 프로젝트의 학습 파일 빈칸 골격을 노션에 생성하고, 사용자가 작성 후 채점까지 진행한다.
---

# 연습 — 맨땅 헤딩 코딩 연습 사이클

두 가지 모드로 동작한다:
- `/연습` : 빈칸 골격 노션 페이지 생성
- `/연습 채점` : 사용자가 작성한 코드 채점

---

## 모드 A: `/연습` — 빈칸 골격 생성

### 1. 연습 파일 파악
UI 선택지를 쓰지 말 것. 아래 형식으로 텍스트 목록을 출력하고 사용자의 채팅 응답을 기다릴 것.
오늘 것뿐 아니라 지금까지 배운 파일 전체가 대상임.

출력 형식 예시:
```
연습할 파일 번호를 입력해줘 (예: 1,3 또는 1-3)

[JWT]
1. JwtUtil
2. JwtRequestFilter

[Security]
3. SecurityConfig

[Members]
4. MembersController
5. MembersService
6. MembersServiceImpl
7. MembersMapper
8. members-mapper.xml
9. MembersVO
10. RefreshTokenVO
```

실제 파일 목록은 프로젝트의 `src/` 를 탐색해서 동적으로 구성할 것.

### 2. 난이도 선택
파일 선택 후 아래 형식으로 텍스트 출력하고 사용자 응답 기다릴 것. UI 선택지 쓰지 말 것.

```
난이도를 입력해줘:
0. 왕초보 — 실제 코드 거의 그대로, 핵심 토큰만 `_____` 빈칸 (fill-in-the-blank)
1. 쉬움 — TODO 힌트에 메서드명까지 알려줌
2. 보통 — 로직 흐름 설명만 (메서드명 없음)
3. 어려움 — 메서드 시그니처만, 힌트 없음
```

### 3. 빈칸 골격 생성 규칙
선택한 파일을 읽고 아래 기준으로 빈칸 버전을 만들 것:

**남기는 것 (골격)**
- 패키지 선언, import문
- 클래스 선언, 어노테이션 (`@Service`, `@RestController` 등)
- 필드 선언 및 `@Autowired`
- 메서드 시그니처 (리턴타입, 메서드명, 파라미터)
- XML이라면 `<mapper namespace>` 와 각 쿼리의 id/parameterType/resultType

**빈칸으로 바꾸는 것 (핵심 로직)**
- 메서드 바디 내부 로직
- SQL 쿼리문 본문
- 난이도에 따라 빈칸 형태 조절

**예시 (왕초보 — fill-in-the-blank)**
실제 코드 거의 그대로 두고, 핵심 토큰만 `_____` 빈칸 처리. 메서드 호출 인자, 변수명, SQL 컬럼/테이블명, 문자열 메시지 등 "핵심 결정 포인트"만.

```java
@PostMapping("/login")
public DataVO getLogin(@RequestBody MembersVO mvo) {
    DataVO dataVO = new DataVO();
    try {
        MembersVO membersVO = membersService._____(mvo.getM_id());
        if(membersVO == null){
            dataVO.setSuccess(Boolean._____);
            dataVO.setMessage("_____");
            return dataVO;
        }
        if(!passwordEncoder.matches(mvo._____(), membersVO._____())){
            dataVO.setSuccess(Boolean.FALSE);
            dataVO.setMessage("_____");
            return dataVO;
        }
        String accessToken = jwtUtil._____(membersVO.getM_id());
        String refreshToken = jwtUtil._____(membersVO.getM_id());
        // ...
    } catch (Exception e) {
        dataVO.setSuccess(Boolean.FALSE);
        dataVO.setMessage("_____" + e.getMessage());
    }
    return dataVO;
}
```

**예시 (보통 난이도)**
```java
@PostMapping("/login")
public DataVO getLogin(@RequestBody MembersVO mvo) {
    DataVO dataVO = new DataVO();
    try {
        // TODO 1: 아이디로 회원 조회

        // TODO 2: 회원 없으면 실패 응답 반환

        // TODO 3: 비밀번호 검증

        // TODO 4: 액세스토큰 + 리프레시토큰 생성

        // TODO 5: 기존 리프레시토큰 삭제 후 새 토큰 저장

        // TODO 6: 성공 응답 반환

    } catch (Exception e) {
        // TODO 7: 예외 처리
    }
    return dataVO;
}
```

### 4. 로컬 파일 생성
프로젝트 루트에 `practice/YYYY-MM-DD/` 폴더를 만들고 그 안에 각 연습 파일을 **원본 확장자 그대로** 생성.

- 위치 예시: `practice/2026-05-13/JwtUtil.java`, `practice/2026-05-13/members-mapper.xml`
- 파일명: 원본 그대로 (`JwtUtil.java`, `MembersController.java`, `members-mapper.xml` 등)
- 파일 내용: 빈칸 골격 코드 (난이도에 따라 형태 다름)
- `README.md` 도 같이 생성: 파일 목록, 난이도, 사용법 안내

**노션은 쓰지 말 것.** 과거에 노션에 올렸는데 Cloudflare 차단 + 코드 블록 직접 편집 불편 등 비효율적이라 로컬 파일 방식으로 확정함. IDE에서 syntax highlighting 받으면서 빈칸 채우는 게 학습/채점 모두에 적합.

### 5. 완료 알림
다음을 출력:
- 생성한 폴더 경로 (`practice/YYYY-MM-DD/`)
- 연습할 파일 목록
- 난이도
- "IDE에서 폴더 열고 `_____` 빈칸 채우세요. 다 끝나면 `/연습 채점` 실행."

---

## 모드 B: `/연습 채점` — 채점

### 1. 연습 파일 찾기
`practice/YYYY-MM-DD/` 의 가장 최근 폴더를 찾을 것 (날짜 내림차순).
폴더 안 파일들을 읽어옴 (`README.md` 제외).

### 2. 실제 코드와 비교
파일명이 같은 실제 코드를 프로젝트에서 찾아 비교.
- `practice/2026-05-13/JwtUtil.java` ↔ `src/main/java/com/study/myproject01/common/jwt/JwtUtil.java`
- 파일명 매칭은 `Glob`으로 `src/**/{파일명}` 검색

### 3. 채점 기준
빈칸이었던 위치(`_____`가 있었던 자리)별로 O/X 체크:
- 메서드/서비스 호출이 맞는가
- 어노테이션/리턴타입/파라미터타입이 맞는가
- SQL이라면 올바른 테이블/컬럼명인가
- 메시지 문자열은 의미 비슷하면 O (완전 일치 요구하지 말 것)

점수: `맞은 빈칸 수 / 전체 빈칸 수`

### 4. 채점 결과 저장
`practice/YYYY-MM-DD/SCORE.md` 파일 생성:
- 파일별 점수
- 전체 점수
- 잘한 점
- 놓친 포인트 + 정답 힌트 (정답 코드 전체는 바로 주지 말 것 — 힌트만)
- 재도전 여부 제안

채팅에는 요약만 출력 (`SCORE.md` 참고하라고 안내).
