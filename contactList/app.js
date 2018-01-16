angular.module('contact', [])
.controller('Contact', function($scope, $http, $window) {
  $http.get('api.json').then(function(response) {
    $scope.contactList = response.data;
  });

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
});
