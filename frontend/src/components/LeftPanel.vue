<script setup lang="ts">
import type { FolderUI } from '../types/ui/folder-ui';


const props = defineProps<{
    folders: FolderUI[]
    selectedFolder: FolderUI | null
}>()

const emit = defineEmits<{
    (e: 'folder-click', folder: FolderUI): void
}>()

const handleClick = (folder: FolderUI) => {
    emit('folder-click', folder)
}
</script>

<template>
    <ul class="list-group list-group-flush">
        <template v-for="folder in folders" :key="folder.id">
            <!-- Root folder -->
            <li class="list-group-item list-group-item-action d-flex align-items-center border-0"
                @click="handleClick(folder)" :class="{ 'active': selectedFolder?.id === folder.id }"
                style="cursor: pointer;">
                <span class="me-2" style="width: 20px; text-align: center;">
                    <i class="fas" :class="folder.isOpen ? 'fa-chevron-down' : 'fa-chevron-right'"
                        style="font-size: 0.8rem; color: #666;"></i>
                </span>
                <i class="fas me-2"
                    :class="folder.isOpen ? 'fa-folder-open text-warning' : 'fa-folder text-warning'"></i>
                <span class="flex-grow-1 small">{{ folder.name }}</span>
                <span v-if="folder.isLoading" class="spinner-border spinner-border-sm text-secondary"></span>
            </li>

            <!-- Child folders -->
            <div v-if="folder.isOpen" class="ms-4 border-start">
                <ul class="list-group list-group-flush">
                    <li v-for="child in folder.children || []" :key="child.id"
                        class="list-group-item list-group-item-action border-0 py-1 d-flex align-items-center"
                        @click.stop="handleClick(child)" :class="{ 'active': selectedFolder?.id === child.id }"
                        style="cursor: pointer;">
                        <i class="fas fa-folder me-2 text-secondary"></i>
                        <span class="small">{{ child.name }}</span>
                    </li>
                </ul>
            </div>
        </template>
    </ul>
</template>
