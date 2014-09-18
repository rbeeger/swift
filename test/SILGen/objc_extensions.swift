// RUN: %swift -emit-silgen -sdk %S/Inputs/ -I %S/Inputs -enable-source-import %s | FileCheck %s

import Foundation
import objc_extensions_helper

class Sub : Base {}

extension Sub {
  override var prop: String! {
    didSet {
      println("set!")
    }
    // CHECK-LABEL: sil [transparent] @_TToFC15objc_extensions3Subg4propGSQSS_
    // CHECK: = super_method [volatile] %1 : $Sub, #Base.prop!setter.1.foreign
    // CHECK: = function_ref @_TFC15objc_extensions3SubW4propGSQSS_
    // CHECK: }
  }
}

// CHECK-LABEL: sil @_TF15objc_extensions20testOverridePropertyFCS_3SubT_
func testOverrideProperty(obj: Sub) {
  // CHECK: = class_method [volatile] %0 : $Sub, #Sub.prop!setter.1
  obj.prop = "abc"
} // CHECK: }

testOverrideProperty(Sub())