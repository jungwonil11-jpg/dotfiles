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

### 4. 노션 페이지 생성
노션 상위 페이지 `🌿 Spring Boot (5월~)` 아래에 연습 페이지를 생성할 것.

페이지 제목: `[연습] YYYY-MM-DD — 파일명`

페이지 구성:
1. **안내 callout**: "아래 골격을 보고 핵심 로직을 직접 채워보세요. 완성 후 `/연습 채점`을 실행하세요."
2. **난이도 표시**: 쉬움 / 보통 / 어려움
3. **파일별 섹션**: 파일명 제목 + 빈칸 골격 코드 블록
4. **내 작성 코드 섹션**: 빈 코드 블록 (사용자가 직접 채울 공간)

### 5. 완료 알림
노션 페이지 링크와 함께 아래를 출력:
- 연습할 파일 목록
- 난이도
- "작성 완료 후 `/연습 채점`을 실행하세요."

---

## 모드 B: `/연습 채점` — 채점

### 1. 연습 페이지 찾기
노션에서 가장 최근 `[연습]` 페이지를 찾아 읽어올 것.
"내 작성 코드" 섹션의 내용을 추출.

### 2. 실제 코드와 비교
프로젝트에서 해당 파일의 실제 코드를 읽어 비교.

### 3. 채점 기준
핵심 포인트별로 O/X 체크:
- 메서드/서비스 호출이 맞는가
- null 체크 등 분기 처리가 있는가
- 예외 처리 구조가 맞는가
- SQL이라면 올바른 테이블/컬럼명인가

점수: `맞은 포인트 수 / 전체 포인트 수`

### 4. 채점 결과를 노션에 추가
해당 연습 페이지 하단에 채점 결과 섹션 추가:
- 점수 (예: 7/10)
- 잘한 점
- 놓친 포인트 + 정답 힌트 (정답 코드 전체는 바로 주지 말 것 — 힌트만)
- 재도전 여부 제안
