import pandas as pd
import os

# ==========================================
# [사용자 설정 영역] 파일 경로 및 컬럼명 세팅
# ==========================================
# 1. SAINTexpress 파일 설정
SAINT_FILE = "260410_triplicate_non-nested design_LFQ.e"  # 파일명 (예: .txt 또는 .csv)
SAINT_SEP = "\t"                  # 텍스트(탭) 파일이면 "\t", CSV 파일이면 ","

SAINT_COL_PREY = "PreyGene"
SAINT_COL_BFDR = "BFDR"
SAINT_COL_AVGP = "AvgP"

# 2. BioGRID 파일 설정
BIOGRID_FILE = "BIOGRID-GENE-120237-5.0.256.tab3.xlsx" # 파일명 (예: .xlsx, .csv, .txt)
BIOGRID_SEP = "\t"                 # 엑셀(.xlsx) 파일일 경우 이 값은 무시됩니다. csv/txt일 때만 작동합니다.

BIOGRID_COL_A = "Official Symbol Interactor A"
BIOGRID_COL_B = "Official Symbol Interactor B"

# 3. 출력 파일명
OUTPUT_FILE = "Filtered_SAINT_with_BioGRID.csv"
# ==========================================

def main():
    print("데이터 분석을 시작합니다...\n")

    # ---------------------------------------------------------
    # 1. BioGRID 데이터 로드 및 고유 리스트(Set) 생성
    # ---------------------------------------------------------
    print(f"[{BIOGRID_FILE}] 읽는 중...")
    try:
        # 파일 확장자에 따라 판다스(Pandas) 읽기 함수를 다르게 적용
        if BIOGRID_FILE.endswith('.xlsx') or BIOGRID_FILE.endswith('.xls'):
            df_biogrid = pd.read_excel(BIOGRID_FILE, usecols=[BIOGRID_COL_A, BIOGRID_COL_B])
        else:
            df_biogrid = pd.read_csv(BIOGRID_FILE, sep=BIOGRID_SEP, usecols=[BIOGRID_COL_A, BIOGRID_COL_B], dtype=str)
    except Exception as e:
        print(f"❌ 에러: BioGRID 파일을 불러올 수 없습니다. ({e})")
        return

    # 정확한 매칭을 위해 결측치 제거, 양옆 공백 제거, 대문자 변환
    interactor_a = df_biogrid[BIOGRID_COL_A].dropna().astype(str).str.strip().str.upper()
    interactor_b = df_biogrid[BIOGRID_COL_B].dropna().astype(str).str.strip().str.upper()

    # 두 열(Column)에 있는 유전자들을 합쳐서 중복 없는 세트(Set)로 만듦
    biogrid_set = set(interactor_a).union(set(interactor_b))
    print(f"✅ BioGRID에서 총 {len(biogrid_set):,}개의 고유 상호작용 유전자를 추출했습니다.\n")

    # ---------------------------------------------------------
    # 2. SAINTexpress 데이터 로드 및 Filtering
    # ---------------------------------------------------------
    print(f"[{SAINT_FILE}] 읽는 중...")
    try:
        df_saint = pd.read_csv(SAINT_FILE, sep=SAINT_SEP)
    except Exception as e:
        print(f"❌ 에러: SAINT 파일을 불러올 수 없습니다. ({e})")
        return

    total_detected = len(df_saint)

    # 데이터 타입을 숫자로 강제 변환 (간혹 엑셀 수식 오류 등으로 텍스트가 섞여 있을 때 에러 방지)
    df_saint[SAINT_COL_BFDR] = pd.to_numeric(df_saint[SAINT_COL_BFDR], errors='coerce')
    df_saint[SAINT_COL_AVGP] = pd.to_numeric(df_saint[SAINT_COL_AVGP], errors='coerce')

    # 필터링: BFDR < 0.05 AND AvgP > 0.8
    df_filtered = df_saint[(df_saint[SAINT_COL_BFDR] < 0.05) & (df_saint[SAINT_COL_AVGP] > 0.8)].copy()
    total_filtered = len(df_filtered)

    # ---------------------------------------------------------
    # 3. Cross-Check (BioGRID 리스트와 비교)
    # ---------------------------------------------------------
    # 비교를 위해 SAINT의 PreyGene 역시 대문자 및 공백 제거 처리
    clean_prey = df_filtered[SAINT_COL_PREY].astype(str).str.strip().str.upper()

    # isin()을 사용하여 BioGRID 리스트에 포함되는지 확인 -> True 또는 False 반환
    df_filtered['is_known_interactor'] = clean_prey.isin(biogrid_set)
    
    known_count = df_filtered['is_known_interactor'].sum()
    novel_count = total_filtered - known_count

    # ---------------------------------------------------------
    # 4. 결과 출력 및 파일 저장
    # ---------------------------------------------------------
    print("-" * 50)
    print("📊 [분석 결과 요약]")
    print(f" - 총 검출 단백질 수 (원본 데이터): {total_detected:,} 개")
    print(f" - 필터링된 단백질 수 (BFDR < 0.05 & AvgP > 0.8): {total_filtered:,} 개")
    print(f" - 그 중 BioGRID에 등록된 기지 상호작용 인자 수: {known_count:,} 개")
    print(f" 🌟 (새로 발굴된 Novel 파트너 수: {novel_count:,} 개)")
    print("-" * 50)

    # CSV 파일로 저장 (utf-8-sig 인코딩으로 나중에 엑셀에서 열 때 한글 깨짐 방지)
    df_filtered.to_csv(OUTPUT_FILE, index=False, encoding='utf-8-sig')
    print(f"💾 분석 결과가 '{OUTPUT_FILE}' 파일로 성공적으로 저장되었습니다.")

if __name__ == "__main__":
    main()