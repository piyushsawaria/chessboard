angular.module('contact', [])
.controller('Contact', function($scope, $http, $window) {
  // $http.get('api.json').then(function(response) {
  //   $scope.contactList = response.data;
  // });

  $scope.contactList = {
	"contacts" : [
		{
			"type" : "Executive",
			"name" : "Ann Brown",
			"title" : "CEO",
			"phone" : "(512)456-5555",
			"ext" : "",
			"fax" : "(512)456-5555",
			"email" : "Executive" 
		},
		{
			"type" : "Inmar AR",
			"name" : "Mary Smith",
			"title" : "Loren Ipsum",
			"phone" : "(512)456-5555",
			"ext" : "",
			"fax" : "(512)456-5555",
			"email" : "Inmar AR"
		},
		{
			"type" : "Executive",
			"name" : "John Doe",
			"title" : "Dolor Sit",
			"phone" : "(512)456-5555",
			"ext" : "",
			"fax" : "(512)456-5555",
			"email" : "Executive"
		},
		{
			"type" : "Daily",
			"name" : "John Doe",
			"title" : "Dolor sit amet",
			"phone" : "(512)456-5555",
			"ext" : "",
			"fax" : "(512)456-5555",
			"email" : "Daily"
		},
		{
			"type" : "Other",
			"name" : "John Doe",
			"title" : "Loren Ipsum",
			"phone" : "(512)456-5555",
			"ext" : "",
			"fax" : "(512)456-5555",
			"email" : "Other"
		}
	]
}

  $scope.addContact = function(){
		$scope.contactList.contacts.push({
			type: $scope.type, 
			name: $scope.name,
			title: $scope.title,
			phone: $scope.phone,
			ext: $scope.ext,
			fax: $scope.fax,
			email: $scope.email
		});
		$scope.type = ""; 
		$scope.name = "";
		$scope.title = "";
		$scope.phone = "";
		$scope.ext = "";
		$scope.fax = "";
		$scope.email = "";
	};

	$scope.deleteContact = function(index){
		if ($window.confirm("Do you want to continue?")){
			$scope.contactList.contacts.splice(index, 1);
		}
	};

	$scope.deleteSelectedContact = function(){
		if ($window.confirm("Do you want to continue?")){
			var newContactList=[];
			angular.forEach($scope.contactList.contacts,function(row){
				if(!row.isChecked){
					newContactList.push(row);
				}
			});
			$scope.contactList.contacts = newContactList;
		}
	};

	$scope.allCheck = function(){
		var check = $scope.isAllChecked
		angular.forEach($scope.contactList.contacts,function(row){
			row.isChecked = check ? true : false;
		});
	};

	$scope.search = function(item){
		if ($scope.searchContact == undefined) {
			return true;
		}
		else{
			if(item.name.toLowerCase().indexOf($scope.searchContact.toLowerCase()) != -1 || item.email.toLowerCase().indexOf($scope.searchContact.toLowerCase()) != -1){
				return true;
			}
		}
		return false;
	};
});
