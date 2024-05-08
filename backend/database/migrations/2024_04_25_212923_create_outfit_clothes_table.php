<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('outfit_clothes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('outfit_id');
            $table->unsignedBigInteger('clothing_id'); 
            $table->foreign('outfit_id')->references('id')->on('outfits')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('clothing_id')->references('id')->on('clothes')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('outfit_clothes');
    }
};
