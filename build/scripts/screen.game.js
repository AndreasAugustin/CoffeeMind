(function(){var e;e="undefined"!=typeof exports&&null!==exports?exports:window,e.coffeeMind=e.coffeeMind||{},e.coffeeMind.screens=e.coffeeMind.screens||{},e.coffeeMind.screens["game-screen"]=function(){var n,r,o,t,l,u,i,c,a,s,m,f,d,v,g,w,C,b,h,p,T,y,x,M,D,S,k,N,L,R,G,z,I,P,A,B,E,O;return O={},E={},c={},l={},s={},a={},v={},i=0,D=0,f={level:0,score:0,timer:{}},T=!1,p=0,I={},R=function(n){return O=e.settings,E=n,l=e.coffeeMind.board,a=e.coffeeMind.display,v=e.coffeeMind.input,s=e.coffeeMind.game,I=e.coffeeMind.storage,i=O.cols,D=O.rows,v.init(E),v.bind("nextColor",h),v.bind("previousColor",y),v.bind("moveLeft",w),v.bind("moveRight",C),v.bind("checkColors",u),v.bind("resetBoard",x),v.bind("getSolution",d),t(),E("#game-screen button[name='exit']").bind("click",function(){var n;return P(!0),n=e.confirm("Do you want to return to the main menu?"),P(!1),n===!0&&(k(),z(),s.showScreen("main-menu")),null}),null},k=function(){return I.set("activeGameData",{level:f.level,score:f.score,time:Date.now()-f.startTime,solution:l.getSolution()}),null},P=function(e){var n,r;if(e!==T)return r=E("#game-screen .pause-overlay")[0],T=e,n=r.style.display,T===!0?(n="block",clearTimeout(f.timer),f.timer=0,p=Date.now()):(n="none",f.startTime+=Date.now()-p,L(!1)),null},z=function(){return clearTimeout(f.timer),null},L=function(e){var n,r,o;return f.timer&&(clearTimeout(f.timer),f.Timer=0),e&&(f.startTime=Date.now(),f.endTime=O.baseLevelTimer*Math.pow(f.level,-.05*f.level)),r=f.startTime+f.endTime-Date.now(),o=r/f.endTime*100,n=E("#game-screen .time .indicator"),0>r?m():(n.width(o+"%"),f.timer=setTimeout(L,30)),null},m=function(){return a.gameOver(function(){return o("Game over"),null})},n=function(e){var n;return n=Math.pow(O.baseLevelScore,Math.pow(O.baseLevelExp,f.level-1)),f.score+=e,f.score>=n&&r(),B(),null},o=function(e){var n;return n=E("#game-screen .announcement"),n.html(e),Modernizr.cssanimations?(n.removeClass("zoomfade"),setTimeout(function(){return n.addClass("zoomfade"),null},1)):(n.addClass("active"),setTimeout(function(){return n.removeClass("active"),null},1e3)),null},G=function(){var n,o,t;return f={level:0,score:0,timer:0,startTime:0,endTime:0},B(),L(!0),l.init(function(){return a.init(E,function(){return l.print(),a.drawAvailableColours(),r(),null}),null}),M(),n=I.get("activeGameData"),n&&(t=e.confirm("Do you want to continue your previous game?")),t===!0&&(f.level=n.level,f.score=n.score,o=n.solution),null},r=function(){return f.level++,O.availableColours<8&&O.availableColours++,o("Level "+f.level),B(),f.startTime=Date.now(),f.endTime=O.baseLevelTimer*Math.pow(f.level,-.05*f.level),L(!0),null},B=function(){return E("#game-screen .score span").html(f.score),E("#game-screen .level span").html(f.level),null},M=function(){return N(0,D-1),null},u=function(){var e,r,t,u;return e=l.checkColors(),r=e.rightColor,t=e.rightPosition,u=e.rowNumber,-1===r?o("Not all cells have been selected"):(a.drawCheckColors(e),b(),n(20*t+10*r)),e.rightPosition===settings.numColors?a.drawSolution(l.getSolution()):0===u&&m(),null},d=function(){return a.drawSolution(l.getSolution()),null},t=function(){return E("#checkColors").bind("click",function(){return u(),null}),E("#resetGame").bind("click",function(){return x(),null}),E("#showSolution").bind("click",function(){return d(),null}),null},x=function(){return M(),l.reset(function(){return a.reset(),null}),null},S=function(e){return R(e),G(),null},h=function(e,n){var r;return(isNaN(e)||isNaN(n))&&(e=c.x,n=c.y),r=l.nextColor(e,n),-1>r?null:(a.myDrawImage(e,n,r),A(),N(e,n),console.log("screen.game nextColor: Color increased at: Column: "+e+"Row: "+n+"New color: "+r),null)},A=function(){var e,n;return e=c.x,n=c.y,a.unRenderCursor(e,n,l.getColor(e,n))},y=function(e,n){var r;return e&&n?N(e,n):(e=c.x,n=c.y),r=l.previousColor(e,n),a.myDrawImage(e,n,r),console.log("Screen.game previousColor: Color decreased at: Column: "+e+"Row: "+n+"New color: "+r),null},C=function(){return A(),g(1,0),null},w=function(){return A(),g(-1,0),null},b=function(){return A(),N(0,c.y-1),null},g=function(e,n){return e+=c.x,n+=c.y,N(e,n),null},N=function(e,n){return c||(c={x:e,y:n}),e>=0&&i>e&&n>=0&&D>n&&(c.x=e,c.y=n),a.renderCursor(e,n,.8),console.log("Cursor set: column: "+c.x+"Row: "+c.y),null},{reset:x,run:S}}()}).call(this);