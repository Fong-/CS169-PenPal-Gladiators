(function(){var e;e=angular.module("StartPageServices",[]),e.service("StartPageData",function(){var e,t,n,r,i;e="",t="",i={},r={},n={},this.getEmail=function(){return e},this.setEmail=function(t){return e=t},this.getPassword=function(){return t},this.setPassword=function(e){return t=e},this.getAllTopics=function(){return i},this.addTopic=function(e){return i[e.id]=e},this.clearAllTopics=function(){return i={}},this.getSelectedTopicIds=function(){return Object.keys(r).sort()},this.addSelectedTopicId=function(e){return r[e]=!0},this.clearSelectedTopicIds=function(){return r={}},this.getResponseIds=function(){var e,t,r,i,o,a,s,u;for(s=[],s=t=0,o=n.length;o>t;s=++t)for(e=n[s],u=i=0,a=s.length;a>i;u=++i)r=s[u],u&&resposneIds.push(r);return s},this.addResponseIdsByTopicId=function(e,t){return n[e]=t},this.clearResponseIdsByTopics=function(){return n={}},this.getResponseIdsByTopicId=function(e){return e in n?n[e]:{}},this.getResponseIdsByTopicIds=function(){return n}})}).call(this);