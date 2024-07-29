<h1 align="center">테크톡</h1>
<p align="center"><img src="https://velog.velcdn.com/images/ximya_hf/post/d6237bb6-be9a-460b-8752-0c2e6407705f/image.png"/></p>
<p align="center"><b>테크톡</b>은 첫 취업 또는 이직을 준비하는 개발자분들 대상으로 <b>기술 면접</b>을 효과적으로 대비할 수 있도록 도와주는 서비스입니다. AI 면접관과 함께 진행하는 모의 면접, 오답 및 학습 노트 등의 기능들을 기반으로 사용자의 기술 면접 준비를 돕습니다. <br/> 실제 취준생활동안 기술 면접을 준비하면서 느꼈던 불편함을 기반으로 서비스를 기획하였으며 , 틈틈이 효과적으로 기술 개념을 학습하기 위한 고민들이 서비스 곳곳에 녹여져 있습니다.</p><br>


<p align="center">
  <a href="https://apps.apple.com/kr/app/id6478161786">
    <img src="https://velog.velcdn.com/images/ximya_hf/post/94c5604a-f8e9-4979-9578-7a8e17d72af8/image.png"
      alt="Platform" />
  </a>
  <a href="https://play.google.com/store/apps/details?id=com.techtalk.ai">
    <img src="https://velog.velcdn.com/images/ximya_hf/post/db4639d8-2241-4a87-a393-0ee64961237d/image.png"
      alt="Pub Package"/>
  </a>
</p>

<br>

# 목차

- [요약](#요약)
- [구현 결과](#구현-결과)
- [폴더 구조](#폴더-구조)
- [프로젝트에 도입된 개념](#프로젝트에-도입된-개념)

# 요약

| Index       | Detail                                                                                                                                                                                                                      |  
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 컨트리뷰터       | <a href="https://github.com/suneogkwon">suneogkwon<a/>, <a href ="https://github.com/Yellowtoast">Yellowtoast</a>, <a href ="https://github.com/yundal8755">yundal8755 </a>, <a href ="https://github.com/Xim-ya">Ximya</a> |
| 상태관리        | rivepord, rxdart                                                                                                                                                                                                            |
| 주요 패키지      | go_router(라우팅), get_it(DI), dio(네트워킹), hive(로컬 데이터베이스), json_serializable(모델링)                                                                                                                                              |
| Flutter SDK | 3.19.1                                                                                                                                                                                                                      |
| 구조          | <img src="https://velog.velcdn.com/images/ximya_hf/post/344edd13-f828-453b-a9c1-7ee076898af6/image.png">                                                                                                                    |

# 구현 결과

|                                                   로그인                                                    |                                               온보딩(닉네임 설정)                                                |                                              온보딩 (관심 직군 설정)                                              |
|:--------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------:|
| <img src="https://velog.velcdn.com/images/ximya_hf/post/69103ac1-d95b-41d3-b600-ea23eb5d4a8b/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/521cc41b-82b8-4599-9bdc-dde29a9c068f/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/b188ffea-d92c-483a-b25e-ad61f84bf64e/image.PNG"> |  
|                                           온보딩 (관심 기술 면접 주제 선택)                                           |                                                  홈 페이지                                                   |                                             면접실 페이지 (데이터 X)                                              |
| <img src="https://velog.velcdn.com/images/ximya_hf/post/90a5eb71-38f6-4039-8f69-0a5614fc0441/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/34430fca-7d16-4ded-9709-a9a9edbfa720/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/8200b83c-6062-410d-91ff-5bdfef971054/image.PNG"> |
|                                             면접 질문 개수 선택 페이지                                              |                                           면접 질문 주제 선택 페이지(실전)                                            |                                           AI 채팅 모의 면접 페이지(주제별)                                           |
| <img src="https://velog.velcdn.com/images/ximya_hf/post/810f56bc-3cf8-45ce-a2cc-d3a4a91f306c/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/b8a40b5f-dcb4-4a81-aba6-07892e90ce7c/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/fab58c77-745e-417d-b80a-78b75e9a3cb0/image.PNG"> |
|                                              AI 채팅 모의 면접 탭뷰                                              |                                            AI 채팅 모의 면접 문답 탭뷰                                             |                                             면접실 페이지 (실전 면접)                                              |
| <img src="https://velog.velcdn.com/images/ximya_hf/post/8f003027-0f9d-4b7f-9b0f-cb8f61961cc1/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/0673e585-74f0-49fc-bdaa-07fca1089d8e/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/ce6c73bb-6e53-4db4-a330-11c3362a84f4/image.PNG"> |
|                                                  학습 페이지                                                  |                                                학습 상세 페이지                                                 |                                          학습 상세 페이지(답안 가리기 활성화)                                           |
| <img src="https://velog.velcdn.com/images/ximya_hf/post/00fd7b76-4a7b-459b-88e0-4a3e3c0a03ff/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/48f71618-5335-4302-a419-af68742fdace/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/9f3b6eb9-d884-484a-a538-d3da43071ff0/image.PNG"> |
|                                             학습 전체 문답 목록 페이지                                              |                                                 오답노트 페이지                                                 |                                               오답 노트 상세 페이지                                               |
| <img src="https://velog.velcdn.com/images/ximya_hf/post/fdecd6dd-7331-4d65-bd72-e360b72f72ac/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/97e1a49f-1d0b-4ba4-808d-064134326c35/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/804d31aa-0100-4de1-800f-78892b6f1a91/image.PNG"> |
|                                                 내 정보 페이지                                                 |                                           내 정보 페이지(수정 팝업 활성화)                                            |
| <img src="https://velog.velcdn.com/images/ximya_hf/post/10ff2b1e-790b-4774-9688-0d3123f864e0/image.PNG"> | <img src="https://velog.velcdn.com/images/ximya_hf/post/6b838bbb-8143-4172-9670-d8cae06b619f/image.PNG"> |

# 폴더 구조

```bash
|-- lib
    |-- app
    |   |-- di
    |   |-- entrypoints
    |   |-- router
    |   |-- style
    |  
    |-- core
    |   |-- constants
    |   |-- helper
    |   |-- modules
    |   |-- services       
    |        
    |-- features
    |   |-- data_source
    |   |   |-- remote
    |   |   |   |-- models
    |   |   |-- local
    |   |   |   |-- boxes     
    |   |-- repository
    |   |   |-- entities
    |   |   |-- enums
    |   |-- useCases
    |   
    |-- presentation
    |   |-- common
    |   |   |-- base
    |   |-- pages
    |   |-- section
    |       |-- widgets
    |       |-- state
    |       |-- event    

```

# 프로젝트에 도입된 개념

- <a href="https://medium.com/@tnsdjr7/flutter-%ED%81%B4%EB%A6%B0-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98%EC%9D%98-%EB%94%94%EB%A0%89%ED%86%A0%EB%A6%AC-%EA%B5%AC%EC%84%B1%EC%97%90-%EB%8C%80%ED%95%9C-%EA%B3%A0%EB%AF%BC-8ea9cfabaf0f">
  Flutter 클린 아키텍처의 디렉토리 구성에 대한 고민</a>
- <a href="https://velog.io/@ximya_hf/Flutter-%EC%99%84%EC%84%B1%EB%8F%84-%EB%86%92%EC%9D%80-%EC%B1%84%ED%8C%85-%EA%B8%B0%EB%8A%A5%EC%9D%84-%EB%A7%8C%EB%93%A4%EA%B8%B0-%EC%9C%84%ED%95%9C-%EC%9D%B8%ED%84%B0%EB%A0%89%EC%85%98-%EB%A1%9C%EC%A7%81%EB%93%A4"> Flutter, 완성도 높은 채팅 기능을 만들기 위한 인터렉션 로직들 </a>
- <a href="https://velog.io/@ximya_hf/organize-your-global-providersinflutterriverpod">Mixin Class를
  활용하여 Riverpod 단점 극복하기 </a>
- <a href="https://velog.io/@ximya_hf/optimizing-network-image-rendering-in-flutter">네트워크 이미지 렌더링을
  최적화하여 메모리 사용량 절감하기</a>
- <a href="https://velog.io/@ximya_hf/flutter-clean-ui-code">내일 바로 써먹는 Flutter Clean UI Code </a>
- <a href="https://velog.io/@ximya_hf/optimizing-network-image-rendering-in-flutter"> 네트워크 이미지 렌더링을 최적화하여 메모리 사용량 절감하기 </a>
- <a href="https://velog.io/@ximya_hf/korean-profanity-filter-based-on-regex"> Flutter 정규 표현식을 이용한 욕설·비속어를 필터링 로직 </a>
- <a href="https://velog.io/@ximya_hf/manangesseveralimportinflutterbysinlgeimport"> 더 빠르고 깔끔하게 Import 하기 : Single Import </a>
- <a href="https://velog.io/@ximya_hf/factory-constructor-base-ui-module"> Factory 생성자로 유연하게 위젯을 모듈화하기 </a>
- <a href="https://velog.io/@ximya_hf/howtowirtutilclasslikepro"> Flutter, 프로답게 유틸리티 class 구현하기 (feat : 메모리 최적화) </a>
- <a href="https://velog.io/@ximya_hf/Flutter-%EC%95%84-%EB%8B%A4%EB%A5%B4%EA%B3%A0-%EC%96%B4-%EB%8B%A4%EB%A5%B8-Extension-%ED%82%A4%EC%9B%8C%EB%93%9C-%ED%99%9C%EC%9A%A9-%ED%8F%AC%EB%A7%B7%ED%8C%85-%EB%A1%9C%EC%A7%81"> Flutter, '아' 다르고 '어' 다른 Extension 키워드 활용 포맷팅 로직 </a>


