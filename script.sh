#!/bin/bash

# دایرکتوری هدف
TARGET_DIR="/c/Users/moham/Documents/GitHub/kamalla"

# لود متغیر محیطی از فایل .lec_counter، اگر تنظیم نشده باشد
if [ -z "$LEC_COUNTER" ] && [ -f "$TARGET_DIR/.lec_counter" ]; then
    source "$TARGET_DIR/.lec_counter"
    echo "LEC_COUNTER از .lec_counter لود شد: $LEC_COUNTER"
fi

# تغییر به دایرکتوری a
cd "$TARGET_DIR" || {
    echo "خطا: نمی‌توان به دایرکتوری $TARGET_DIR دسترسی پیدا کرد"
    exit 1
}
echo "دایرکتوری فعلی: $(pwd)"

# بررسی و مقداردهی اولیه متغیر محیطی LEC_COUNTER
if [ -z "$LEC_COUNTER" ]; then
    export LEC_COUNTER="001"
    echo "LEC_COUNTER با مقدار اولیه 001 تنظیم شد"
fi

# اطمینان از اینکه عدد سه‌رقمی است
NUMBER=$(printf "%03d" "$LEC_COUNTER")
echo "شماره پروژه فعلی: $NUMBER"

# بررسی تغییرات Git
if [ -n "$(git status --porcelain)" ]; then
    echo "اجرای دستورات Git..."
    git add .
    git commit -m "ll" || {
        echo "خطا: کامیت ناموفق بود"
        exit 1
    }
    git push origin main || {
        echo "خطا: push ناموفق بود"
        exit 1
    }
else
    echo "هیچ تغییری برای کامیت وجود ندارد"
fi

# نام پروژه
PROJECT_NAME="lec$NUMBER"
echo "نام پروژه: $PROJECT_NAME"

# بررسی وجود پروژه
if [ -d "$PROJECT_NAME" ]; then
    # بررسی اینکه آیا دایرکتوری یک پروژه Rust معتبر است
    if [ -f "$PROJECT_NAME/Cargo.toml" ] && [ -d "$PROJECT_NAME/src" ]; then
        echo "پروژه $PROJECT_NAME معتبر است، وارد آن می‌شویم"
    else
        echo "دایرکتوری $PROJECT_NAME ناقص است، حذف و ایجاد مجدد"
        rm -rf "$PROJECT_NAME" || {
            echo "خطا: نمی‌توان دایرکتوری $PROJECT_NAME را حذف کرد"
            exit 1
        }
        cargo new "$PROJECT_NAME" || {
            echo "خطا: نمی‌توان پروژه $PROJECT_NAME را ایجاد کرد"
            exit 1
        }
    fi
else
    echo "ایجاد پروژه جدید: $PROJECT_NAME"
    cargo new "$PROJECT_NAME" || {
        echo "خطا: نمی‌توان پروژه $PROJECT_NAME را ایجاد کرد"
        exit 1
    }
fi

# ورود به دایرکتوری پروژه
cd "$PROJECT_NAME" || {
    echo "خطا: نمی‌توان به دایرکتوری $PROJECT_NAME وارد شد"
    exit 1
}
echo "وارد دایرکتوری پروژه شدیم: $(pwd)"

# اجرای پروژه
echo "اجرای پروژه $PROJECT_NAME..."
cargo run || {
    echo "خطا: اجرای پروژه ناموفق بود"
    exit 1
}

# بازگشت به دایرکتوری a
cd "$TARGET_DIR" || {
    echo "خطا: نمی‌توان به دایرکتوری $TARGET_DIR بازگشت"
    exit 1
}
echo "بازگشت به دایرکتوری: $(pwd)"

# افزایش عدد برای اجرای بعدی
NEXT_NUMBER=$((10#$NUMBER + 1))
export LEC_COUNTER=$(printf "%03d" "$NEXT_NUMBER")
echo "LEC_COUNTER به $LEC_COUNTER افزایش یافت"

# ذخیره متغیر محیطی برای جلسات بعدی
echo "export LEC_COUNTER=$LEC_COUNTER" > "$TARGET_DIR/.lec_counter"
echo "متغیر محیطی در .lec_counter ذخیره شد"