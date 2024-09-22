import t from"./getPrototypeOf.js";import r from"./isNativeReflectConstruct.js";import e from"./possibleConstructorReturn.js";import"./typeof.js";import"./assertThisInitialized.js";function _createSuper(o){var s=r();return function(){var r,i=t(o);if(s){var p=t(this).constructor;r=Reflect.construct(i,arguments,p)}else r=i.apply(this,arguments);return e(this,r)}}export{_createSuper as default};

