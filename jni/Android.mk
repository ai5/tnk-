# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ARCH_DEF := -DTARGET_ARCH="$(TARGET_ARCH_ABI)"
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
  ARCH_DEF += -DIS_64BIT -DIS_ARM -DUSE_MAKEFILE -DNNUE_ENGINE -DUSE_SSE42
endif

ifeq ($(TARGET_ARCH_ABI),x86_64)
  ARCH_DEF += -DUSE_SSE42 -DUSE_MAKEFILE  -DNNUE_ENGINE -msse4.2
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  ARCH_DEF += -DUSE_MAKEFILE  -DNNUE_ENGINE
endif

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  ARCH_DEF += -DIS_ARM -DUSE_MAKEFILE -DNNUE_ENGINE -DUSE_SSE42  -mfpu=neon
endif

LOCAL_MODULE    := YaneuraOu-$(TARGET_ARCH_ABI)
LOCAL_CXXFLAGS  := -std=c++14 -fno-exceptions -fno-rtti -Wextra -Ofast -MMD -MP -fpermissive -D__STDINT_MACROS -D__STDC_LIMIT_MACROS $(ARCH_DEF)
LOCAL_CXXFLAGS += -fPIE
LOCAL_LDFLAGS += -fPIE -pie
LOCAL_LDLIBS = 
LOCAL_C_INCLUDES := 
LOCAL_CPP_FEATURES += exceptions rtti
#LOCAL_STATIC_LIBRARIES    := -lpthread

LOCAL_SRC_FILES := ../source/bitboard.cpp ../source/misc.cpp ../source/movegen.cpp ../source/position.cpp \
           ../source/shogi.cpp ../source/thread.cpp ../source/tt.cpp ../source/usi.cpp \
           ../source/eval/evaluate.cpp ../source/eval/evaluate_io.cpp \
           ../source/eval/evaluate_bona_piece.cpp \
           ../source/eval/nn/evaluate_nn.cpp \
           ../source/eval/nn/evaluate_nn_learner.cpp \
           ../source/eval/nn/nn_test_command.cpp \
           ../source/eval/nn/features/half_kp.cpp \
           ../source/eval/nn/features/half_relative_kp.cpp \
           ../source/eval/nn/features/k.cpp \
           ../source/eval/nn/features/p.cpp \
           ../source/extra/bitop.cpp ../source/extra/entering_king_win.cpp \
           ../source/extra/book/book.cpp \
           ../source/extra/book/apery_book.cpp \
           ../source/extra/long_effect.cpp \
           ../source/extra/mate/mate1ply_without_effect.cpp ../source/extra/mate/mate1ply_with_effect.cpp \
           ../source/extra/mate/mate_n_ply.cpp \
           ../source/move_picker.cpp \
           ../source/extra/see.cpp \
           ../source/extra/test_cmd.cpp ../source/extra/benchmark.cpp \
           ../source/extra/timeman.cpp \
           ../source/engine/2018-otafuku-engine/2018-otafuku-search.cpp \
           ../source/engine/user-engine/user-search.cpp

include $(BUILD_EXECUTABLE)
