/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/graderapp.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/graderapp.js":
/*!*******************************************!*\
  !*** ./app/javascript/packs/graderapp.js ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports) {

var index = 0;

window.addNewTimeSlot = function () {
  var weekday = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;
  var startTime = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;
  var endTime = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 0;
  var form = document.getElementById('availability_template').cloneNode(true);
  form.id = "";
  form.style.display = 'flex';
  form.querySelector('#availability_weekday').setAttribute('name', 'availability[' + index + '][weekday]');
  form.querySelector('#availability_weekday').setAttribute('value', weekday);
  form.querySelector('#availability_start_time').setAttribute('name', 'availability[' + index + '][start_time]');
  form.querySelector('#availability_end_time').setAttribute('name', 'availability[' + index + '][end_time]');
  var list = document.getElementById('availabilities');
  index++;
  list.append(form);
};

var courseIndex = 0;

window.addNewCourse = function () {
  var form = document.getElementById('course_template').cloneNode(true);
  form.id = "";
  form.style.display = 'flex';
  form.querySelector('#course_id').setAttribute('name', 'courses[' + courseIndex + '][course_id]');
  courseIndex++;
  var list = document.getElementById('courses');
  list.append(form);
};

/***/ })

/******/ });
//# sourceMappingURL=graderapp-32be9671ce0c5c42e432.js.map