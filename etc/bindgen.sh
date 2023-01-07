#!/usr/bin/env bash

cd "$(dirname $0)"

# We replace the FT_ integer types of known widths, since we can do better.
#
# We blacklist FT_Error and import our own in order to have convenience methods
# on it instead of being a plain integer.
"${BINDGEN}" bindings.h -o ../src/freetype.rs \
  --blocklist-type "FT_(Int16|UInt16|Int32|UInt32|Int16|Int64|UInt64)" \
  --raw-line "pub type FT_Int16 = i16;" \
  --raw-line "pub type FT_UInt16 = u16;" \
  --raw-line "pub type FT_Int32 = i32;" \
  --raw-line "pub type FT_UInt32 = u32;" \
  --raw-line "pub type FT_Int64= i64;" \
  --raw-line "pub type FT_UInt64= u64;" \
  --blocklist-type "FT_Error" \
  --raw-line "pub use FT_Error;" \
  --generate=functions,types,vars       \
  --allowlist-function="FT_.*"         \
  --allowlist-type="FT_.*"             \
  --allowlist-var="FT_.*"             \
  -- -I"../../freetype-sys/freetype2/include"
