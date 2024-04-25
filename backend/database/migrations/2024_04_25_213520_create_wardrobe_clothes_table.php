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
        Schema::create('wardrobe_clothes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('clothes_id');
            $table->unsignedBigInteger('wardrobe_id');
            $table->timestamps();
            $table->foreign('clothes_id')->references('id')->on('clothes')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('wardrobe_id')->references('id')->on('wardrobe')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('wardrobe_clothes');
    }
};
