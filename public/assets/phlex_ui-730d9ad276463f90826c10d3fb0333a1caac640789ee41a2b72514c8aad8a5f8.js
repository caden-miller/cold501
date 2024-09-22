import{Application as e,Controller as t}from"@hotwired/stimulus";import{animate as s}from"motion";import{format as i}from"date-fns";import r from"mustache";import o from"chart.js/auto";import a from"tippy.js";import n from"fuse.js";const l=e.start();l.debug=false;window.Stimulus=l;class AccordionController extends t{static targets=["icon","content"];static values={open:{type:Boolean,default:false},animationDuration:{type:Number,default:.15},animationEasing:{type:String,default:"ease-in-out"},rotateIcon:{type:Number,default:180}};connect(){let e=this.animationDurationValue;this.animationDurationValue=0;this.openValue?this.open():this.close();this.animationDurationValue=e}toggle(){this.openValue=!this.openValue}openValueChanged(e,t){e?this.open():this.close()}open(){if(this.hasContentTarget){this.revealContent();this.hasIconTarget&&this.rotateIcon();this.openValue=true}}close(){if(this.hasContentTarget){this.hideContent();this.hasIconTarget&&this.rotateIcon();this.openValue=false}}revealContent(){const e=this.contentTarget.scrollHeight;s(this.contentTarget,{height:`${e}px`},{duration:this.animationDurationValue,easing:this.animationEasingValue})}hideContent(){s(this.contentTarget,{height:0},{duration:this.animationDurationValue,easing:this.animationEasingValue})}rotateIcon(){s(this.iconTarget,{rotate:`${this.openValue?this.rotateIconValue:0}deg`})}}class AlertDialogController extends t{static targets=["content"];static values={open:{type:Boolean,default:false}};connect(){this.openValue&&this.open()}open(){document.body.insertAdjacentHTML("beforeend",this.contentTarget.innerHTML)}}class CalendarController extends t{static targets=["calendar","title","weekdaysTemplate","selectedDateTemplate","todayDateTemplate","currentMonthDateTemplate","otherMonthDateTemplate"];static values={selectedDate:{type:String,default:null},viewDate:{type:String,default:(new Date).toISOString().slice(0,10)},format:{type:String,default:"yyyy-MM-dd"}};static outlets=["input"];initialize(){this.updateCalendar()}nextMonth(e){e.preventDefault();this.viewDateValue=this.adjustMonth(1)}prevMonth(e){e.preventDefault();this.viewDateValue=this.adjustMonth(-1)}selectDay(e){e.preventDefault();this.selectedDateValue=e.currentTarget.dataset.day}selectedDateValueChanged(e,t){const s=new Date(this.selectedDateValue);s.setDate(2);this.viewDateValue=s.toISOString().slice(0,10);this.updateCalendar();this.inputOutlets.forEach((e=>{const t=this.formatDate(this.selectedDate());e.setValue(t)}))}viewDateValueChanged(e,t){this.updateCalendar()}adjustMonth(e){const t=this.viewDate();t.setDate(2);t.setMonth(t.getMonth()+e);return t.toISOString().slice(0,10)}updateCalendar(){this.titleTarget.textContent=this.monthAndYear();this.calendarTarget.innerHTML=this.calendarHTML()}calendarHTML(){return this.weekdaysTemplateTarget.innerHTML+this.calendarDays()}calendarDays(){return this.getFullWeeksStartAndEndInMonth().map((e=>this.renderWeek(e))).join("")}renderWeek(e){const t=e.map((e=>this.renderDay(e))).join("");return`<tr class="flex w-full mt-2">${t}</tr>`}renderDay(e){const t=new Date;let s="";const i={day:e,dayDate:e.getDate()};s=e.toDateString()===this.selectedDate().toDateString()?r.render(this.selectedDateTemplateTarget.innerHTML,i):e.toDateString()===t.toDateString()?r.render(this.todayDateTemplateTarget.innerHTML,i):e.getMonth()===this.viewDate().getMonth()?r.render(this.currentMonthDateTemplateTarget.innerHTML,i):r.render(this.otherMonthDateTemplateTarget.innerHTML,i);return s}monthAndYear(){const e=this.viewDate().toLocaleString("default",{month:"long"});const t=this.viewDate().getFullYear();return`${e} ${t}`}selectedDate(){return new Date(this.selectedDateValue)}viewDate(){return this.viewDateValue?new Date(this.viewDateValue):this.selectedDate()}getFullWeeksStartAndEndInMonth(){const e=this.viewDate().getMonth();const t=this.viewDate().getFullYear();let s=[],i=new Date(t,e,1),r=new Date(t,e+1,0),o=r.getDate();let a=1;let n;if(i.getDay()===1)n=7;else if(i.getDay()===0){let s=new Date(t,e,0);a=s.getDate()-6+1;n=1}else{let r=new Date(t,e,0);a=r.getDate()+1-i.getDay()+1;n=7-i.getDay()+1;s.push({start:a,end:n});a=n+1;n+=7}while(a<=o){s.push({start:a,end:n});a=n+1;n+=7;n=a===1&&n===8?1:n;if(n>o&&a<=o){n-=o;s.push({start:a,end:n});break}}return s.map((({start:s,end:i},r)=>{const o=+(s>i&&r===0);return Array.from({length:7},((i,r)=>{const a=new Date(t,e-o,s+r);return a}))}))}formatDate(e){return i(e,this.formatValue)}}class ChartController extends t{static values={options:{type:Object,default:{}}};connect(){this.initDarkModeObserver();this.initChart()}disconnect(){this.darkModeObserver?.disconnect();this.chart?.destroy()}initChart(){this.setColors();const e=this.element.getContext("2d");this.chart=new o(e,this.mergeOptionsWithDefaults())}setColors(){this.setDefaultColorsForChart()}getThemeColor(e){const t=getComputedStyle(document.documentElement).getPropertyValue(`--${e}`);const[s,i,r]=t.split(" ");return`hsl(${s}, ${i}, ${r})`}defaultThemeColor(){return{backgroundColor:this.getThemeColor("background"),hoverBackgroundColor:this.getThemeColor("accent"),borderColor:this.getThemeColor("primary"),borderWidth:1}}setDefaultColorsForChart(){o.defaults.color=this.getThemeColor("muted-foreground");o.defaults.borderColor=this.getThemeColor("border");o.defaults.backgroundColor=this.getThemeColor("background");o.defaults.plugins.tooltip.backgroundColor=this.getThemeColor("background");o.defaults.plugins.tooltip.borderColor=this.getThemeColor("border");o.defaults.plugins.tooltip.titleColor=this.getThemeColor("foreground");o.defaults.plugins.tooltip.bodyColor=this.getThemeColor("muted-foreground");o.defaults.plugins.tooltip.borderWidth=1;o.defaults.plugins.legend.labels.boxWidth=12;o.defaults.plugins.legend.labels.boxHeight=12;o.defaults.plugins.legend.labels.borderWidth=0;o.defaults.plugins.legend.labels.useBorderRadius=true;o.defaults.plugins.legend.labels.borderRadius=this.getThemeColor("radius")}refreshChart(){this.chart?.destroy();this.initChart()}initDarkModeObserver(){this.darkModeObserver=new MutationObserver((()=>{this.refreshChart()}));this.darkModeObserver.observe(document.documentElement,{attributeFilter:["class"]})}mergeOptionsWithDefaults(){return{...this.optionsValue,data:{...this.optionsValue.data,datasets:this.optionsValue.data.datasets.map((e=>({...this.defaultThemeColor(),...e})))}}}}class ClipboardController extends t{static targets=["trigger","source","successPopover","errorPopover"];connect(){this.tippySuccess=this.initializeTippy("success");this.tippyError=this.initializeTippy("error")}disconnect(){this.tippySuccess.destroy();this.tippyError.destroy()}copy(){let e=this.sourceTarget.children[0];if(!e){this.showErrorPopover();return}let t=e.tagName==="INPUT"?e.value:e.innerText;navigator.clipboard.writeText(t).then((()=>{this.showSuccessPopover()})).catch((()=>{this.showErrorPopover()}))}showSuccessPopover(){this.tippySuccess.show();setTimeout((()=>this.hideSuccessPopover()),2500)}showErrorPopover(){this.tippyError.show();setTimeout((()=>this.hideErrorPopover()),2500)}hideSuccessPopover(){this.tippySuccess.hide()}hideErrorPopover(){this.tippyError.hide()}initializeTippy(e){let t=e==="success"?this.successPopoverTarget:this.errorPopoverTarget;const s={content:t.innerHTML,allowHTML:true,interactive:false,trigger:"manual"};return a(this.triggerTarget,s)}}class CollapsibleController extends t{static targets=["content"];static values={open:{type:Boolean,default:false}};connect(){this.openValue?this.open():this.close()}toggle(){this.openValue=!this.openValue}openValueChanged(e,t){e?this.open():this.close()}open(){if(this.hasContentTarget){this.contentTarget.classList.remove("hidden");this.openValue=true}}close(){if(this.hasContentTarget){this.contentTarget.classList.add("hidden");this.openValue=false}}}class CommandController extends t{static targets=["input","group","item","empty"];connect(){this.inputTarget.focus();this.searchIndex=this.buildSearchIndex();this.toggleVisibility(this.emptyTargets,false);this.selectedIndex=-1}filter(e){this.deselectAll();const t=e.target.value.toLowerCase();if(t.length===0){this.resetVisibility();return}this.toggleVisibility(this.itemTargets,false);const s=this.searchIndex.search(t);s.forEach((e=>this.toggleVisibility([e.item.element],true)));this.toggleVisibility(this.emptyTargets,s.length===0);this.updateGroupVisibility()}toggleVisibility(e,t){e.forEach((e=>e.classList.toggle("hidden",!t)))}updateGroupVisibility(){this.groupTargets.forEach((e=>{const t=e.querySelectorAll("[data-command-target='item']:not(.hidden)").length>0;this.toggleVisibility([e],t)}))}resetVisibility(){this.toggleVisibility(this.itemTargets,true);this.toggleVisibility(this.groupTargets,true);this.toggleVisibility(this.emptyTargets,false)}buildSearchIndex(){const e={keys:["value"],threshold:.2,includeMatches:true};const t=this.itemTargets.map((e=>({value:e.dataset.value,element:e})));return new n(t,e)}handleKeydown(e){const t=this.itemTargets.filter((e=>!e.classList.contains("hidden")));if(e.key==="ArrowDown"){e.preventDefault();this.updateSelectedItem(t,1)}else if(e.key==="ArrowUp"){e.preventDefault();this.updateSelectedItem(t,-1)}else if(e.key==="Enter"&&this.selectedIndex!==-1){e.preventDefault();t[this.selectedIndex].click()}}updateSelectedItem(e,t){this.selectedIndex>=0&&this.toggleAriaSelected(e[this.selectedIndex],false);this.selectedIndex+=t;this.selectedIndex<0?this.selectedIndex=e.length-1:this.selectedIndex>=e.length&&(this.selectedIndex=0);this.toggleAriaSelected(e[this.selectedIndex],true)}toggleAriaSelected(e,t){e.setAttribute("aria-selected",t.toString())}deselectAll(){this.itemTargets.forEach((e=>this.toggleAriaSelected(e,false)));this.selectedIndex=-1}}class DialogController extends t{static targets=["content"];static values={open:{type:Boolean,default:false}};open(e){e.preventDefault();document.body.insertAdjacentHTML("beforeend",this.contentTarget.innerHTML);document.body.classList.add("overflow-hidden")}}class DismissableController extends t{dismiss(e){document.body.classList.remove("overflow-hidden");this.element.remove()}}class InputController extends t{setValue(e){this.element.value=e}}class PopoverController extends t{static targets=["trigger","content","menuItem"];static values={options:{type:Object,default:{}},matchWidth:{type:Boolean,default:false}};connect(){console.log("Hello from PopoverController");this.boundHandleKeydown=this.handleKeydown.bind(this);this.initializeTippy();console.log(this.optionsValue);this.selectedIndex=-1}disconnect(){this.destroyTippy()}initializeTippy(){console.log("init tippy");const e={content:this.contentTarget.innerHTML,allowHTML:true,interactive:true,onShow:e=>{this.matchWidthValue&&this.setContentWidth(e);this.addEventListeners()},onHide:()=>{this.removeEventListeners();this.deselectAll()},popperOptions:{modifiers:[{name:"offset",options:{offset:[0,4]}}]}};const t={...this.optionsValue,...e};console.log(t);this.tippy=a(this.triggerTarget,t)}destroyTippy(){this.tippy&&this.tippy.destroy()}setContentWidth(e){const t=e.popper.querySelector(".tippy-content");t&&(t.style.width=`${e.reference.offsetWidth}px`)}handleContextMenu(e){e.preventDefault();this.open()}open(){this.tippy.show()}close(){this.tippy.hide()}handleKeydown(e){if(this.menuItemTargets.length!==0)if(e.key==="ArrowDown"){e.preventDefault();this.updateSelectedItem(1)}else if(e.key==="ArrowUp"){e.preventDefault();this.updateSelectedItem(-1)}else if(e.key==="Enter"&&this.selectedIndex!==-1){e.preventDefault();this.menuItemTargets[this.selectedIndex].click()}}updateSelectedItem(e){this.menuItemTargets.forEach(((e,t)=>{e.getAttribute("aria-selected")==="true"&&(this.selectedIndex=t)}));this.selectedIndex>=0&&this.toggleAriaSelected(this.menuItemTargets[this.selectedIndex],false);this.selectedIndex+=e;this.selectedIndex<0?this.selectedIndex=this.menuItemTargets.length-1:this.selectedIndex>=this.menuItemTargets.length&&(this.selectedIndex=0);this.toggleAriaSelected(this.menuItemTargets[this.selectedIndex],true)}toggleAriaSelected(e,t){t?e.setAttribute("aria-selected","true"):e.removeAttribute("aria-selected")}deselectAll(){this.menuItemTargets.forEach((e=>this.toggleAriaSelected(e,false)));this.selectedIndex=-1}addEventListeners(){document.addEventListener("keydown",this.boundHandleKeydown)}removeEventListeners(){document.removeEventListener("keydown",this.boundHandleKeydown)}}class SelectController extends t{static targets=["item"];static outlets=["input","text"];connect(){this.setSelectedItem()}setSelectedItem(){const e=this.selectedItem();this.itemTargets.forEach((e=>{e.removeAttribute("data-selected")}));if(e){e.setAttribute("data-selected","true");e.setAttribute("aria-selected","true")}}selectedItem(){return this.itemTargets.find((e=>e.dataset.value===this.inputOutlets[0].element.value))}selectItem(e){e.preventDefault();const t=e.currentTarget.dataset.value;const s=e.currentTarget.innerText;this.setValue(t);this.setInnerText(s)}setValue(e){this.inputOutlets.forEach((t=>{t.setValue(e)}))}setInnerText(e){this.textOutlets.forEach((t=>{t.setText(e)}))}}class TabsController extends t{static targets=["trigger","content"];static values={active:String};connect(){!this.hasActiveValue&&this.triggerTargets.length>0&&(this.activeValue=this.triggerTargets[0].dataset.value)}show(e){this.activeValue=e.currentTarget.dataset.value}activeValueChanged(e,t){if(e!=""&&e!=t){this.contentTargets.forEach((e=>{e.classList.add("hidden")}));this.triggerTargets.forEach((e=>{e.dataset.state="inactive"}));this.activeContentTarget()&&this.activeContentTarget().classList.remove("hidden");this.activeTriggerTarget().dataset.state="active"}}activeTriggerTarget(){return this.triggerTargets.find((e=>e.dataset.value==this.activeValue))}activeContentTarget(){return this.contentTargets.find((e=>e.dataset.value==this.activeValue))}}class TextController extends t{setText(e){this.element.innerText=e}}class ToggleThemeController extends t{initialize(){this.setTheme()}setTheme(){if(localStorage.theme==="dark"||!("theme"in localStorage)&&window.matchMedia("(prefers-color-scheme: dark)").matches){document.documentElement.classList.add("dark");document.documentElement.classList.remove("light")}else{document.documentElement.classList.remove("dark");document.documentElement.classList.add("light")}}setLightTheme(){localStorage.theme="light";this.setTheme()}setDarkTheme(){localStorage.theme="dark";this.setTheme()}}class SheetController extends t{static targets=["content"];static values={open:{type:Boolean,default:false}};open(e){document.body.insertAdjacentHTML("beforeend",this.contentTarget.innerHTML)}}l.register("accordion",AccordionController);l.register("alert-dialog",AlertDialogController);l.register("calendar",CalendarController);l.register("chart",ChartController);l.register("clipboard",ClipboardController);l.register("collapsible",CollapsibleController);l.register("command",CommandController);l.register("dialog",DialogController);l.register("dismissable",DismissableController);l.register("input",InputController);l.register("popover",PopoverController);l.register("select",SelectController);l.register("tabs",TabsController);l.register("text",TextController);l.register("toggle-theme",ToggleThemeController);l.register("sheet",SheetController);export{AccordionController,AlertDialogController,CalendarController,ChartController,ClipboardController,CollapsibleController,CommandController,DialogController,DismissableController,InputController,PopoverController,SelectController,SheetController,TabsController,TextController,ToggleThemeController,l as application};

