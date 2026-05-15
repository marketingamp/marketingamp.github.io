#!/bin/bash

BASE="/sessions/great-nifty-goodall/mnt/affiliate/website/content"

# Category display names
declare -A CAT_NAMES
CAT_NAMES[ai-writing]="AI Writing"
CAT_NAMES[email-marketing]="Email Marketing"
CAT_NAMES[landing-pages]="Landing Pages"
CAT_NAMES[seo-tools]="SEO Tools"
CAT_NAMES[vpn-security]="VPN \&amp; Security"
CAT_NAMES[website-builders]="Website Builders"
CAT_NAMES[all-in-one]="All-in-One"

# Function to get title from file
get_title() {
  grep -oP '<h1[^>]*>\K[^<]+' "$BASE/$1/$2" | head -1
}

# Function to insert related section
insert_related() {
  local cat="$1" file="$2" r1_cat="$3" r1_file="$4" r2_cat="$5" r2_file="$6" r3_cat="$7" r3_file="$8"
  
  local r1_title=$(get_title "$r1_cat" "$r1_file")
  local r2_title=$(get_title "$r2_cat" "$r2_file")
  local r3_title=$(get_title "$r3_cat" "$r3_file")
  
  local r1_catname="${CAT_NAMES[$r1_cat]}"
  local r2_catname="${CAT_NAMES[$r2_cat]}"
  local r3_catname="${CAT_NAMES[$r3_cat]}"
  
  local filepath="$BASE/$cat/$file"
  
  local block="<section class=\"related-articles\">\n  <h2>You Might Also Like<\/h2>\n  <div class=\"related-grid\">\n    <a href=\"\/content\/$r1_cat\/$r1_file\" class=\"related-card\">\n      <span class=\"related-category\">$r1_catname<\/span>\n      <h3>$r1_title<\/h3>\n    <\/a>\n    <a href=\"\/content\/$r2_cat\/$r2_file\" class=\"related-card\">\n      <span class=\"related-category\">$r2_catname<\/span>\n      <h3>$r2_title<\/h3>\n    <\/a>\n    <a href=\"\/content\/$r3_cat\/$r3_file\" class=\"related-card\">\n      <span class=\"related-category\">$r3_catname<\/span>\n      <h3>$r3_title<\/h3>\n    <\/a>\n  <\/div>\n<\/section>"
  
  sed -i "s|  <footer class=\"site-footer\">|$block\n  <footer class=\"site-footer\">|" "$filepath"
  echo "Done: $cat/$file"
}

# AI Writing (7 articles) - cross-links to SEO Tools
insert_related "ai-writing" "best-ai-writing-tools.html" \
  "ai-writing" "jasper-vs-copy-ai.html" \
  "ai-writing" "writesonic-review.html" \
  "seo-tools" "best-keyword-research-tools.html"

insert_related "ai-writing" "jasper-vs-copy-ai.html" \
  "ai-writing" "best-ai-writing-tools.html" \
  "ai-writing" "writesonic-review.html" \
  "seo-tools" "semrush-review.html"

insert_related "ai-writing" "writesonic-review.html" \
  "ai-writing" "best-ai-writing-tools.html" \
  "ai-writing" "jasper-vs-copy-ai.html" \
  "seo-tools" "best-seo-tools-small-business.html"

insert_related "ai-writing" "best-ai-tools-for-content-marketing.html" \
  "ai-writing" "best-ai-writing-tools.html" \
  "ai-writing" "best-ai-tools-for-seo.html" \
  "email-marketing" "best-email-automation-tools.html"

insert_related "ai-writing" "best-ai-writing-tools-free.html" \
  "ai-writing" "best-ai-writing-tools.html" \
  "ai-writing" "jasper-vs-copy-ai.html" \
  "seo-tools" "semrush-vs-ahrefs.html"

insert_related "ai-writing" "best-ai-tools-for-seo.html" \
  "ai-writing" "best-ai-tools-for-content-marketing.html" \
  "ai-writing" "best-ai-writing-tools.html" \
  "seo-tools" "semrush-review.html"

insert_related "ai-writing" "best-ai-image-generators.html" \
  "ai-writing" "best-ai-writing-tools.html" \
  "ai-writing" "best-ai-tools-for-content-marketing.html" \
  "all-in-one" "best-social-media-management-tools.html"

# Email Marketing (6 articles) - cross-links to Landing Pages
insert_related "email-marketing" "best-email-marketing-platforms.html" \
  "email-marketing" "kit-review.html" \
  "email-marketing" "mailerlite-vs-mailchimp.html" \
  "landing-pages" "best-landing-page-builders.html"

insert_related "email-marketing" "kit-review.html" \
  "email-marketing" "best-email-marketing-platforms.html" \
  "email-marketing" "convertkit-vs-mailchimp.html" \
  "landing-pages" "best-landing-pages-for-lead-generation.html"

insert_related "email-marketing" "mailerlite-vs-mailchimp.html" \
  "email-marketing" "best-email-marketing-platforms.html" \
  "email-marketing" "convertkit-vs-mailchimp.html" \
  "landing-pages" "leadpages-vs-unbounce.html"

insert_related "email-marketing" "best-email-automation-tools.html" \
  "email-marketing" "best-email-marketing-platforms.html" \
  "email-marketing" "kit-review.html" \
  "landing-pages" "best-landing-page-builders.html"

insert_related "email-marketing" "convertkit-vs-mailchimp.html" \
  "email-marketing" "kit-review.html" \
  "email-marketing" "mailerlite-vs-mailchimp.html" \
  "landing-pages" "best-free-landing-page-builders.html"

insert_related "email-marketing" "best-email-marketing-for-ecommerce.html" \
  "email-marketing" "best-email-marketing-platforms.html" \
  "email-marketing" "best-email-automation-tools.html" \
  "all-in-one" "best-ecommerce-platforms.html"

# Landing Pages (5 articles) - cross-links to Email Marketing
insert_related "landing-pages" "best-landing-page-builders.html" \
  "landing-pages" "leadpages-vs-unbounce.html" \
  "landing-pages" "best-landing-pages-for-lead-generation.html" \
  "email-marketing" "best-email-marketing-platforms.html"

insert_related "landing-pages" "leadpages-vs-unbounce.html" \
  "landing-pages" "best-landing-page-builders.html" \
  "landing-pages" "instapage-review.html" \
  "email-marketing" "best-email-automation-tools.html"

insert_related "landing-pages" "best-landing-pages-for-lead-generation.html" \
  "landing-pages" "best-landing-page-builders.html" \
  "landing-pages" "best-free-landing-page-builders.html" \
  "email-marketing" "kit-review.html"

insert_related "landing-pages" "best-free-landing-page-builders.html" \
  "landing-pages" "best-landing-page-builders.html" \
  "landing-pages" "leadpages-vs-unbounce.html" \
  "email-marketing" "mailerlite-vs-mailchimp.html"

insert_related "landing-pages" "instapage-review.html" \
  "landing-pages" "best-landing-page-builders.html" \
  "landing-pages" "leadpages-vs-unbounce.html" \
  "all-in-one" "best-sales-funnel-builders.html"

# SEO Tools (4 articles) - cross-links to AI Writing
insert_related "seo-tools" "semrush-review.html" \
  "seo-tools" "semrush-vs-ahrefs.html" \
  "seo-tools" "best-keyword-research-tools.html" \
  "ai-writing" "best-ai-tools-for-seo.html"

insert_related "seo-tools" "best-seo-tools-small-business.html" \
  "seo-tools" "semrush-review.html" \
  "seo-tools" "best-keyword-research-tools.html" \
  "ai-writing" "best-ai-writing-tools.html"

insert_related "seo-tools" "semrush-vs-ahrefs.html" \
  "seo-tools" "semrush-review.html" \
  "seo-tools" "best-seo-tools-small-business.html" \
  "ai-writing" "best-ai-tools-for-content-marketing.html"

insert_related "seo-tools" "best-keyword-research-tools.html" \
  "seo-tools" "semrush-review.html" \
  "seo-tools" "semrush-vs-ahrefs.html" \
  "ai-writing" "best-ai-tools-for-seo.html"

# VPN & Security (6 articles) - cross-links to Website Builders
insert_related "vpn-security" "best-vpn-2026.html" \
  "vpn-security" "nordvpn-vs-surfshark.html" \
  "vpn-security" "best-vpn-for-privacy.html" \
  "website-builders" "best-website-builders-small-business.html"

insert_related "vpn-security" "nordvpn-vs-surfshark.html" \
  "vpn-security" "best-vpn-2026.html" \
  "vpn-security" "expressvpn-vs-nordvpn.html" \
  "website-builders" "best-managed-wordpress-hosting.html"

insert_related "vpn-security" "best-vpn-streaming.html" \
  "vpn-security" "best-vpn-2026.html" \
  "vpn-security" "nordvpn-vs-surfshark.html" \
  "website-builders" "squarespace-vs-wix.html"

insert_related "vpn-security" "best-vpn-for-privacy.html" \
  "vpn-security" "best-vpn-2026.html" \
  "vpn-security" "expressvpn-vs-nordvpn.html" \
  "website-builders" "best-managed-wordpress-hosting.html"

insert_related "vpn-security" "best-vpn-small-business.html" \
  "vpn-security" "best-vpn-2026.html" \
  "vpn-security" "best-vpn-for-privacy.html" \
  "website-builders" "best-website-builders-small-business.html"

insert_related "vpn-security" "expressvpn-vs-nordvpn.html" \
  "vpn-security" "nordvpn-vs-surfshark.html" \
  "vpn-security" "best-vpn-2026.html" \
  "website-builders" "framer-review.html"

# Website Builders (4 articles) - cross-links to VPN/Security
insert_related "website-builders" "best-website-builders-small-business.html" \
  "website-builders" "squarespace-vs-wix.html" \
  "website-builders" "framer-review.html" \
  "vpn-security" "best-vpn-small-business.html"

insert_related "website-builders" "framer-review.html" \
  "website-builders" "best-website-builders-small-business.html" \
  "website-builders" "squarespace-vs-wix.html" \
  "landing-pages" "best-landing-page-builders.html"

insert_related "website-builders" "squarespace-vs-wix.html" \
  "website-builders" "best-website-builders-small-business.html" \
  "website-builders" "framer-review.html" \
  "all-in-one" "best-ecommerce-platforms.html"

insert_related "website-builders" "best-managed-wordpress-hosting.html" \
  "website-builders" "best-website-builders-small-business.html" \
  "website-builders" "squarespace-vs-wix.html" \
  "seo-tools" "best-seo-tools-small-business.html"

# All-in-One (13 articles) - cross-links to various categories
insert_related "all-in-one" "clickfunnels-alternatives.html" \
  "all-in-one" "systeme-io-review.html" \
  "all-in-one" "best-sales-funnel-builders.html" \
  "landing-pages" "best-landing-page-builders.html"

insert_related "all-in-one" "systeme-io-review.html" \
  "all-in-one" "clickfunnels-alternatives.html" \
  "all-in-one" "best-sales-funnel-builders.html" \
  "email-marketing" "best-email-marketing-platforms.html"

insert_related "all-in-one" "best-sales-funnel-builders.html" \
  "all-in-one" "clickfunnels-alternatives.html" \
  "all-in-one" "systeme-io-review.html" \
  "landing-pages" "leadpages-vs-unbounce.html"

insert_related "all-in-one" "kajabi-vs-teachable.html" \
  "all-in-one" "best-online-course-platforms.html" \
  "all-in-one" "systeme-io-review.html" \
  "email-marketing" "kit-review.html"

insert_related "all-in-one" "best-ecommerce-platforms.html" \
  "all-in-one" "best-sales-funnel-builders.html" \
  "all-in-one" "clickfunnels-alternatives.html" \
  "email-marketing" "best-email-marketing-for-ecommerce.html"

insert_related "all-in-one" "best-crm-small-business.html" \
  "all-in-one" "best-project-management-tools.html" \
  "all-in-one" "best-invoicing-software.html" \
  "email-marketing" "best-email-automation-tools.html"

insert_related "all-in-one" "best-project-management-tools.html" \
  "all-in-one" "best-crm-small-business.html" \
  "all-in-one" "best-invoicing-software.html" \
  "ai-writing" "best-ai-tools-for-content-marketing.html"

insert_related "all-in-one" "best-online-course-platforms.html" \
  "all-in-one" "kajabi-vs-teachable.html" \
  "all-in-one" "best-webinar-platforms.html" \
  "landing-pages" "best-landing-pages-for-lead-generation.html"

insert_related "all-in-one" "best-invoicing-software.html" \
  "all-in-one" "best-accounting-software-small-business.html" \
  "all-in-one" "best-crm-small-business.html" \
  "website-builders" "best-website-builders-small-business.html"

insert_related "all-in-one" "best-webinar-platforms.html" \
  "all-in-one" "best-online-course-platforms.html" \
  "all-in-one" "best-video-editing-software.html" \
  "landing-pages" "best-landing-page-builders.html"

insert_related "all-in-one" "best-social-media-management-tools.html" \
  "all-in-one" "best-video-editing-software.html" \
  "all-in-one" "best-project-management-tools.html" \
  "ai-writing" "best-ai-image-generators.html"

insert_related "all-in-one" "best-accounting-software-small-business.html" \
  "all-in-one" "best-invoicing-software.html" \
  "all-in-one" "best-crm-small-business.html" \
  "all-in-one" "best-ecommerce-platforms.html"

insert_related "all-in-one" "best-video-editing-software.html" \
  "all-in-one" "best-social-media-management-tools.html" \
  "all-in-one" "best-webinar-platforms.html" \
  "ai-writing" "best-ai-image-generators.html"

echo ""
echo "=== VERIFICATION ==="
count=$(grep -rl "related-articles" $BASE/*/  --include="*.html" | grep -v index.html | wc -l)
echo "Articles with related-articles section: $count"
