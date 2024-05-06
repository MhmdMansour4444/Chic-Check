<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\ClothController;
use App\Http\Controllers\OutfitController;
use App\Http\Controllers\ForumController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\WardrobeController;
use App\Http\Controllers\ItemCompatibilityController;
use App\Http\Controllers\WardrobeClothController;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::post('/refresh', [AuthController::class, 'refresh']);


Route::group(["middleware" => 'auth'], function () {

    // User routes
    Route::post('/users', [UserController::class, 'create']);
    Route::get('/users/{id}', [UserController::class, 'getUser']);
    Route::put('/users/{id}', [UserController::class, 'update']);
    Route::delete('/users/{id}', [UserController::class, 'delete']);
});
Route::get('/users', [UserController::class, 'showAllUsers']);

// categories routes
Route::post('/categories', [CategoryController::class, 'create']);
Route::get('/categories', [CategoryController::class, 'get']);
Route::put('/categories/{id}', [CategoryController::class, 'update']);
Route::delete('/categories/{id}', [CategoryController::class, 'delete']);

//clothings routes
Route::post('/clothes', [ClothController::class, 'create']);
Route::get('/clothes', [ClothController::class, 'get']);
Route::put('/clothes/{id}', [ClothController::class, 'update']);
Route::delete('/clothes/{id}', [ClothController::class, 'delete']);

// Outfit routes
Route::post('/outfits', [OutfitController::class, 'create']);
Route::get('/outfits', [OutfitController::class, 'get']);
Route::put('/outfits/{id}', [OutfitController::class, 'update']);
Route::delete('/outfits/{id}', [OutfitController::class, 'delete']);

// Forum routes
Route::post('/forums', [ForumController::class, 'create']);
Route::get('/forums', [ForumController::class, 'get']);
Route::put('/forums/{id}', [ForumController::class, 'update']);
Route::delete('/forums/{id}', [ForumController::class, 'delete']);


// Post routes
Route::post('/posts', [PostController::class, 'create']);
Route::get('/posts', [PostController::class, 'get']);
Route::delete('/posts/{id}', [PostController::class, 'delete']);

// Wardrobe routes
Route::post('/wardrobes', [WardrobeController::class, 'create']);
Route::get('/wardrobes', [WardrobeController::class, 'get']);
Route::put('/wardrobes/{id}', [WardrobeController::class, 'update'])->middleware('auth');
Route::delete('/wardrobes/{id}', [WardrobeController::class, 'delete']);

// ItemCompatibility routes
Route::post('/item-compatibilities', [ItemCompatibilityController::class, 'create']);
Route::get('/item-compatibilities', [ItemCompatibilityController::class, 'index']);
Route::delete('/item-compatibilities/{id}', [ItemCompatibilityController::class, 'delete']);

// WardrobeCloth routes
Route::post('/wardrobe-clothes/{wardrobeId}', [WardrobeClothController::class, 'attachClothToWardrobe']);
Route::delete('/wardrobe-clothes/{wardrobeId}', [WardrobeClothController::class, 'detachClothFromWardrobe']);