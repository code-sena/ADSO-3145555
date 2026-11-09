# Architecture, Traceability, and Technical Verification of a Web and Mobile Platform for Restaurant Operations: The SaborExpress Case Study

**Yerson Stiven Cuéllar Rubiano** · SENA CIES, ADSO 3145555 · 3 noviembre 2026 / November 3, 2026

**Abstract.** This paper examines which claims about SaborExpress integration can be supported by versioned repository evidence and reported test executions. A descriptive documentary case study combines targeted literature surveillance, contract inspection, and a review of published validation records. SaborExpress integrates an ASP.NET Core 8 API, a Next.js web client and an Expo/React Native mobile client supporting restaurant ordering, kitchen, cashier, payment and delivery workflows. A November 3, 2026 documentation report records 90 security, 62 QA and 11 PDF-invoice local backend tests passed on a candidate SHA, along with 7 web and 8 mobile tests on distinct versions. These outcomes concern limited test suites and do not establish overall acceptance. Candidate backend readiness returned HTTP 503 locally because migrations were pending, whereas an earlier staging SHA had passed its smoke checks. The case supports architectural characterization and partial validation but not causal improvements, full production readiness or user acceptance. Reproducible evaluation instruments and remaining gaps are presented.

**Keywords:** restaurant information systems; software engineering; case study; traceability; validation; web and mobile applications

## I. INTRODUCTION

Restaurant operations integrate catalogues, branches, employees, orders, kitchens, payments and deliveries. Changes in backend permissions or state contracts may affect independent web and mobile clients. Food-delivery literature investigates trust, perceived quality and user experience [1]–[5], and technology adoption models offer variables for future field work [6], [7]. These publications do not constitute evidence of SaborExpress outcomes. This study explicitly distinguishes declared architecture, observed testing, outstanding validation and evidence limitations.

## II. RESEARCH PROBLEM AND OBJECTIVES

Earlier documentation identified plausible risks involving order consistency, payments, branch isolation and delivery coordination, but did not establish a baseline from an actual restaurant. The analytical problem tree treats insufficiently demonstrated operational traceability as its central problem; hypothetical causes include inter-client contract drift, incomplete cross-branch authorization coverage and dependencies on third-party payment services. Effects such as inconsistent states remain hypotheses, not measured incidents. Research question: Which integration capabilities and technical verification results can be reproducibly identified in SaborExpress, and what evidence is missing before operational readiness can be claimed? The objectives are to identify components, relate risks to literature and standards, report results by SHA and environment, and design reproducible functional and user-study instruments.

## III. RELATED WORK AND TECHNOLOGY SURVEILLANCE

Shroff et al. [1] and Shankar et al. [2] survey the online food-delivery domain. Prasetyo et al. [3], Fakfare [4] and Koay et al. [5] examine satisfaction and service attributes in settings distinct from this project. Davis [6] and Venkatesh et al. [7] provide constructs for a future acceptance study rather than measured results here. Kruchten [8] supports architectural views and Taibi et al. [9] provides comparative patterns without suggesting that a modular backend must be a microservice system. Yin [10] informs case-study evidence; Kitchenham and Charters [11] inform transparent source selection without making this a registered systematic review. ISO/IEC 25010 [12], OWASP [13], and HTTP/JWT specifications [14], [15] inform quality and security criteria. The companion surveillance matrix contains 15 sources, identifiers, summaries and limitations.

## IV. METHODS AND INSTRUMENTS

This is a descriptive, documentary, non-experimental case study updated to November 3, 2026. The bounded system includes SaborExpressBack, SaborExpressWeb, SaborExpressMovil and SaborExpressDocs. Documentary instruments are the technology extraction record, static API-client contract table, and assessment of the 9-traceability/CIERRE-HU-2026-11-03.md report. Evidence is classified into executed checks linked to a version, static implementation findings, and unexecuted proposals. No participants were recruited or interviewed in preparing this revision. Reproduction requires repository SHA, runtime environment, commands and CI artefacts. Personal data, secrets and actual payment transactions are excluded.

## V. OBSERVED RESULTS

SaborExpress documents a central ASP.NET Core 8/EF Core backend with JWT authentication and SignalR, a Next.js administrative interface and an Expo/React Native mobile app. It covers branches, catalogue, employees, orders, kitchen operations, payments and deliveries. A previously generated OpenAPI snapshot reports 269 routes, 346 operations and 84 schemas; these counts are not runtime validation. Static route-and-method comparison found 92/92 matching Web signatures and 47/47 Mobile signatures against the earlier backend OpenAPI; payload and behavior contracts were not tested. The backend candidate SHA 17a8ce4 reports 90/90 Security, 62/62 QA and 11/11 Invoice PDF local tests passing. Web SHA aa5cb8d reports 7/7 tests and Mobile SHA af52bba reports 8/8 tests. A local web Playwright check used synthetic API data and passed a single test spanning 11 screens; it is not a user study. Candidate backend local /health returned 200 and /health/ready returned 503 owing to pending migrations. An earlier staging SHA ac2b39e passed smoke verification on October 29, 2026, but did not validate the candidate. Historical k6 evidence included one run satisfying thresholds and two failing the Server-Timing header requirement. These are extracted documentary results, not tests re-executed to create this paper.

## VI. DISCUSSION AND VALIDITY

Unit and CI tests establish bounded behavior, not complete production workflows. The latest backend candidate remained outside main, while web and mobile records represent other versions. Static route matches do not establish authorization, idempotent processing or concurrent consistency. OWASP cross-branch checks, Wompi event signature and replay protection, reconnection, secret rotation and full seven-role journeys require further execution. Construct validity is limited because route declarations differ from observed behavior. Internal validity is limited by the lack of a before-and-after experiment. External validity is restricted to this case. Reproducibility depends on immutable SHAs, execution records and controlled environments. No actual restaurant interview or user acceptance survey is reported.

## VII. FUTURE VALIDATION PROTOCOL

A field pilot should recruit an authorized operational representative and users with informed consent. The researcher should record branch, role, task, version, observation date and anticipated result; apply a semi-structured interview and a task observation sheet; anonymize responses and preserve failures. A separate isolated test environment should cover seven roles across two branches, forbidden object access, duplicate or modified payment webhook events in sandbox, network reconnection, declared load-test thresholds, migration rollback, recovery and physical-device/printing validation. Companion templates are ready for use but have not been applied.


### Scope and scientific contribution

The operational concern identified in repository documentation must be distinguished from the research problem. Restaurant orders, kitchens, payments and deliveries may require close coordination, but no incident rate has been measured at a specific establishment. The research problem is instead to establish which claims about a multi-client implementation can be supported by traceable evidence. The contribution is a reproducible triangulation method joining code artefacts, API contracts and versioned test records, not a causal experiment or commercial benchmark.

Three analytical propositions guide evidence collection: P1, shared routes and domain models can document an integration architecture; P2, a test executed on one version supports only the behavior covered in that version; and P3, user satisfaction, productivity and production readiness cannot be inferred without integrated workflows and participant evidence. These propositions are not presented as statistically tested hypotheses.

### Literature selection and appraisal

The technology-surveillance matrix includes fifteen references relevant to restaurant operations, software architecture, research methods, requirements and security. It separates empirical studies and reviews, theoretical models, methodological guidance and standards. Selection was based on thematic relevance, a public DOI or stable URL, and applicability to a research decision. No exhaustive search string, PRISMA flow, independent risk-of-bias assessment or repeatable exclusion count was documented. This is therefore a *targeted review*, not a systematic review. Vendor material may document integration interfaces but cannot replace empirical studies of outcomes.

Food-delivery research [1]–[5] suggests constructs for a future study; TAM and UTAUT [6], [7] support questions about usefulness and ease of use. Architectural views [8] and pattern comparisons [9] caution against calling a modular backend a proven microservices deployment. ISO/IEC 25010 [12] is adopted as a quality taxonomy, while OWASP [13] and the HTTP/JWT specifications [14], [15] inform controls without certifying the analysed system.

### Extraction protocol and bias management

The bounded case comprises SaborExpressBack, SaborExpressWeb, SaborExpressMovil and SaborExpressDocs. A reproducible evidence row records repository, path or test URL, complete commit SHA, date, environment, examined artefact, observation and scope limit. E1 denotes a reported executed check with an identifiable result; E2 a reproducible static inspection; and E3 an unexecuted proposal. Outcomes taken from existing documentation are explicitly *reported*, not re-run by the present manuscript editor.

Four safeguards were adopted: never aggregate test counts from different versions into one quality percentage; include failures and blocked checks; separate local runs from CI checks and deployments; and distinguish system evidence from assumptions about restaurant operations. No probabilistic sampling or on-site restaurant observation has occurred. Some metrics depend on a project evidence report and should be checked against original execution artefacts by an independent reviewer.

### Interpretation by evaluation dimension

**Architecture and contracts.** The OpenAPI inventory contains 269 paths, 346 operations and 84 schemas as reported for an earlier backend SHA. This describes a generated specification, not successful execution of every operation. The 92 web and 47 mobile route-and-method matches verify static signatures but not JSON payloads, authorization, error handling or concurrent transactions. Registered JWT or SignalR components alone do not demonstrate effective access control or guaranteed event delivery.

**Security.** Ninety local security tests reportedly passed on backend candidate `17a8ce4`. This is bounded regression evidence rather than an exhaustive penetration test: cross-branch journeys across seven roles, rotation of historical secrets and staging-level object authorization still require attention. For payments, the existence of Wompi endpoints must be separated from cryptographic event verification and transactional reconciliation; both latter behaviors require specific evidence.

**Reliability and deployment.** The backend candidate returned `/health` HTTP 200 but `/health/ready` HTTP 503 owing to pending migrations. Liveness and operational readiness must therefore be distinguished. The satisfactory staging smoke of an earlier SHA does not invalidate or resolve the current local readiness outcome. Historical k6 runs yielded one threshold-compliant execution and two runs that failed the `Server-Timing` requirement; this mixed evidence cannot be presented as uniformly successful load validation on the latest candidate.

**Usability.** One Playwright test against synthetic API data across eleven screens is not equivalent to an evaluation with actual restaurant staff or customers. No observed participant task-completion rates, operator timings or acceptance scores are available. These measures remain reserved for the planned field pilot, and external validity remains limited.

### Findings-to-acceptance traceability

| Dimension | Reported evidence | Supported conclusion | Outstanding validation |
|---|---|---|---|
| API contracts | OpenAPI; web 92/92; mobile 47/47 | Static route/method correspondence | Runtime payloads, errors and sessions |
| Backend | Security 90/90, QA 62/62, PDF 11/11 | Bounded local suites passed for a SHA | Candidate CI and integrated journeys |
| Web/mobile | 7/7 and 8/8 at their SHAs | Client-specific test suites passed | Physical devices and all roles |
| Readiness | Local 503; previous staging smoke passed | Different status across versions/environments | Controlled migration and repeat smoke |
| Performance | One k6 pass, two failed checks | Mixed historical evidence | Controlled repeated runs |
| Field context | Interview template only | No empirical restaurant diagnosis | Authorized participant interview |

### Reproducible follow-up evaluation

The proposed field pilot must specify an authorized restaurant, participant role, task, date, consent and data-handling rules before recruitment. The workflow from catalogue through delivery can then be observed for elapsed time, errors, retries and comments without recording identifying information. Responses should be anonymized and analyzed descriptively. No sample size, score or participant quotation is fabricated in this article.

Technical validation requires an isolated environment, synthetic data, two branches and seven role accounts. Every test should log preconditions, method, expected/observed outcomes, evidence, full SHA and blocking causes. Priorities include branch-level authorization, idempotent Wompi webhook handling, network recovery, cashier closures, kitchen state synchronization, reversible migrations and physical mobile-printing tests. Passing a local test does not substitute for reproducing that test on the same version in staging.


### Explicit mapping to the SENA learning guide GFPI-F-135 V04

The guide defines four research stages. Stage one requires three cases (one provided by the instructor, a literature-based case and an actual product-context case), interviews with three real users, and a problem tree revised in light of their accounts. At this point only a documentary analysis of SaborExpress and relevant published research is available. Neither the instructor's case nor field interviews and a verified restaurant case have been supplied. The current problem tree is therefore preliminary, not evidence of participants' needs.

Stage two requires a consistency matrix connecting research question, objective, activity, output and verification; a pilot involving at least two users is planned but no execution or participant outcomes are claimed. Stage three separates at least six academic studies, three official technical references and three existing solutions. Stage four reports versioned technical test evidence without extrapolation to users or production. Companion annexes contain case, consistency and technology-surveillance matrices, a search strategy, and fieldwork forms awaiting genuine data.

**Verifiable objective mapping.** Architecture is assessed against files and specifications in the four repositories; quality evidence against versioned QA reports; and the real productive context can only be assessed after interviews and the pilot have been conducted. The documentary objective is therefore partially supported while claims regarding restaurant needs and acceptance remain open.

## VIII. CONCLUSIONS

The study documents a multi-client restaurant platform and a traceability chain linking source code, standards and versioned validation outcomes. Local tests and CI artefacts offer real evidence beyond static inspection, but are insufficient for claims of user acceptance, complete production readiness, or closure of every user story. The research contribution is a reproducible distinction between observed implementation, bounded verification and the field and technical evaluation needed to test the remaining hypotheses.

## IX. DECLARATIONS

Manuscript author named: Yerson Stiven Cuéllar Rubiano, subject to personal confirmation of authorship and contribution. Affiliation: SENA, Centro de la Industria, la Empresa y los Servicios, ADSO cohort 3145555. Funding and conflicts: not established in the supplied record; the author must confirm them before submission. Ethics: no participants were enrolled in preparing this revision; future participant studies require consent and institutional authorization. Evidence: cited public repositories and their versioned reports. Artificial intelligence: ChatGPT (OpenAI, GPT-6 family) assisted on November 3, 2026 with restructuring, drafting, translation and document generation. Reported test outcomes were extracted from existing project evidence, not experimentally generated by the assistant. The human author must verify references, review claims and approve the declaration; any additional tools used must also be disclosed.

## REFERENCES

[1] Shroff, A., Shah, B. J., and Gajjar, H., “Online food delivery research: A systematic literature review,” *International Journal of Contemporary Hospitality Management*, 2022. https://doi.org/10.1108/IJCHM-10-2021-1273

[2] Shankar, A. et al., “Online food delivery: A systematic synthesis of literature and a framework development,” *International Journal of Hospitality Management*, 2022. https://doi.org/10.1016/j.ijhm.2022.103240

[3] Prasetyo, Y. T. et al., “Factors affecting customer satisfaction and loyalty in online food delivery service during the COVID-19 pandemic,” *Journal of Open Innovation: Technology, Market, and Complexity*, 2021. https://doi.org/10.3390/joitmc7010076

[4] Fakfare, P., “Influence of service attributes of food delivery application on customers’ satisfaction and their behavioural responses: The IPMA approach,” *International Journal of Gastronomy and Food Science*, 2021. https://doi.org/10.1016/j.ijgfs.2021.100392

[5] Koay, K. Y., Cheah, C. W., and Chang, Y. X., “A model of online food delivery service quality, customer satisfaction and customer loyalty: A combination of PLS-SEM and NCA approaches,” *British Food Journal*, 2022. https://doi.org/10.1108/BFJ-10-2021-1169

[6] Davis, F. D., “Perceived usefulness, perceived ease of use, and user acceptance of information technology,” *MIS Quarterly*, 1989. https://doi.org/10.2307/249008

[7] Venkatesh, V. et al., “User acceptance of information technology: Toward a unified view,” *MIS Quarterly*, 2003. https://doi.org/10.2307/30036540

[8] Kruchten, P., “The 4+1 view model of architecture,” *IEEE Software*, 1995. https://doi.org/10.1109/52.469759

[9] Taibi, D., Lenarduzzi, V., and Pahl, C., “Architectural patterns for microservices: A systematic mapping study,” *CLOSER 2018*, 2018. https://doi.org/10.5220/0006798302210232

[10] Yin, R. K., “Case Study Research and Applications: Design and Methods,” *SAGE, 6th ed.*, 2018. https://study.sagepub.com/yin6e

[11] Kitchenham, B., and Charters, S., “Guidelines for performing systematic literature reviews in software engineering,” *EBSE-2007-01*, 2007. https://homepages.dcc.ufmg.br/~figueiredo/disciplinas/papers/guidelines-kitchenham.pdf

[12] ISO/IEC, “ISO/IEC 25010:2023 — Product quality model,” *ISO standard*, 2023. https://www.iso.org/standard/78176.html

[13] OWASP Foundation, “OWASP API Security Top 10 — 2023,” *OWASP*, 2023. https://owasp.org/API-Security/

[14] Fielding, R., Nottingham, M., and Reschke, J., “HTTP Semantics (RFC 9110),” *IETF*, 2022. https://www.rfc-editor.org/rfc/rfc9110

[15] Jones, M., Bradley, J., and Sakimura, N., “JSON Web Token (JWT) (RFC 7519),” *IETF*, 2015. https://www.rfc-editor.org/rfc/rfc7519


Sources and traceability / Fuentes y trazabilidad:
- https://github.com/yersonct/SaborExpressDocs/blob/main/9-traceability/CIERRE-HU-2026-11-03.md
- https://github.com/yersonct/SaborExpressDocs/blob/f77625c469fe21f0e660e946c9741474817a524b/docs-SaborExpress/07_Articulo_investigacion_SaborExpress_ES.md
- https://github.com/yersonct/SaborExpressBack
- https://github.com/yersonct/SaborExpressWeb
- https://github.com/yersonct/SaborExpressMovil
